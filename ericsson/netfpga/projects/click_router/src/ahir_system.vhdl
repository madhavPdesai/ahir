-- VHDL produced by vc2vhdl from virtual circuit (vc) description 
library ieee;
use ieee.std_logic_1164.all;
package vc_system_package is -- 
  constant foo_base_address : std_logic_vector(3 downto 0) := "0000";
  constant free_queue_base_address : std_logic_vector(2 downto 0) := "000";
  constant free_queue_ram_base_address : std_logic_vector(10 downto 0) := "00000000000";
  constant mempool_base_address : std_logic_vector(0 downto 0) := "0";
  constant xx_xstr10_base_address : std_logic_vector(6 downto 0) := "0000000";
  constant xx_xstr11_base_address : std_logic_vector(6 downto 0) := "0000000";
  constant xx_xstr12_base_address : std_logic_vector(6 downto 0) := "0000000";
  constant xx_xstr1_base_address : std_logic_vector(6 downto 0) := "0000000";
  constant xx_xstr2_base_address : std_logic_vector(6 downto 0) := "0000000";
  constant xx_xstr3_base_address : std_logic_vector(6 downto 0) := "0000000";
  constant xx_xstr4_base_address : std_logic_vector(7 downto 0) := "00000000";
  constant xx_xstr5_base_address : std_logic_vector(6 downto 0) := "0000000";
  constant xx_xstr6_base_address : std_logic_vector(6 downto 0) := "0000000";
  constant xx_xstr7_base_address : std_logic_vector(6 downto 0) := "0000000";
  constant xx_xstr8_base_address : std_logic_vector(6 downto 0) := "0000000";
  constant xx_xstr9_base_address : std_logic_vector(6 downto 0) := "0000000";
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
entity free_queue_manager is -- 
  generic (tag_length : integer); 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic;
    memory_space_2_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_2_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_lr_addr : out  std_logic_vector(2 downto 0);
    memory_space_2_lr_tag :  out  std_logic_vector(2 downto 0);
    memory_space_2_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_2_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_lc_data : in   std_logic_vector(7 downto 0);
    memory_space_2_lc_tag :  in  std_logic_vector(2 downto 0);
    memory_space_2_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_2_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_sr_addr : out  std_logic_vector(2 downto 0);
    memory_space_2_sr_data : out  std_logic_vector(7 downto 0);
    memory_space_2_sr_tag :  out  std_logic_vector(2 downto 0);
    memory_space_2_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_2_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_sc_tag :  in  std_logic_vector(2 downto 0);
    free_queue_request_pipe_read_req : out  std_logic_vector(0 downto 0);
    free_queue_request_pipe_read_ack : in   std_logic_vector(0 downto 0);
    free_queue_request_pipe_read_data : in   std_logic_vector(7 downto 0);
    free_queue_put_pipe_read_req : out  std_logic_vector(0 downto 0);
    free_queue_put_pipe_read_ack : in   std_logic_vector(0 downto 0);
    free_queue_put_pipe_read_data : in   std_logic_vector(31 downto 0);
    free_queue_ack_pipe_write_req : out  std_logic_vector(0 downto 0);
    free_queue_ack_pipe_write_ack : in   std_logic_vector(0 downto 0);
    free_queue_ack_pipe_write_data : out  std_logic_vector(7 downto 0);
    free_queue_get_pipe_write_req : out  std_logic_vector(0 downto 0);
    free_queue_get_pipe_write_ack : in   std_logic_vector(0 downto 0);
    free_queue_get_pipe_write_data : out  std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
  );
  -- 
end entity free_queue_manager;
architecture Default of free_queue_manager is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal start_req_symbol: Boolean;
  signal start_ack_symbol: Boolean;
  signal fin_req_symbol: Boolean;
  signal fin_ack_symbol: Boolean;
  signal tag_push, tag_pop: std_logic; 
  signal start_ack_sig, fin_ack_sig: std_logic; 
  -- output port buffer signals
  signal free_queue_manager_CP_0_start: Boolean;
  -- links between control-path and data-path
  signal ptr_deref_167_load_0_req_0 : boolean;
  signal ptr_deref_167_load_0_ack_0 : boolean;
  signal ptr_deref_167_load_0_req_1 : boolean;
  signal ptr_deref_167_load_0_ack_1 : boolean;
  signal ptr_deref_167_gather_scatter_req_0 : boolean;
  signal ptr_deref_167_gather_scatter_ack_0 : boolean;
  signal binary_173_inst_req_0 : boolean;
  signal binary_173_inst_ack_0 : boolean;
  signal binary_173_inst_req_1 : boolean;
  signal binary_173_inst_ack_1 : boolean;
  signal ptr_deref_76_gather_scatter_req_0 : boolean;
  signal ptr_deref_76_gather_scatter_ack_0 : boolean;
  signal ptr_deref_76_store_0_req_0 : boolean;
  signal ptr_deref_76_store_0_ack_0 : boolean;
  signal ptr_deref_76_store_0_req_1 : boolean;
  signal ptr_deref_76_store_0_ack_1 : boolean;
  signal ptr_deref_87_gather_scatter_req_0 : boolean;
  signal ptr_deref_87_gather_scatter_ack_0 : boolean;
  signal ptr_deref_87_store_0_req_0 : boolean;
  signal ptr_deref_87_store_0_ack_0 : boolean;
  signal ptr_deref_87_store_0_req_1 : boolean;
  signal ptr_deref_87_store_0_ack_1 : boolean;
  signal ptr_deref_98_gather_scatter_req_0 : boolean;
  signal ptr_deref_98_gather_scatter_ack_0 : boolean;
  signal ptr_deref_98_store_0_req_0 : boolean;
  signal ptr_deref_98_store_0_ack_0 : boolean;
  signal ptr_deref_98_store_0_req_1 : boolean;
  signal ptr_deref_98_store_0_ack_1 : boolean;
  signal ptr_deref_109_gather_scatter_req_0 : boolean;
  signal ptr_deref_109_gather_scatter_ack_0 : boolean;
  signal ptr_deref_109_store_0_req_0 : boolean;
  signal ptr_deref_109_store_0_ack_0 : boolean;
  signal ptr_deref_109_store_0_req_1 : boolean;
  signal ptr_deref_109_store_0_ack_1 : boolean;
  signal simple_obj_ref_122_inst_req_0 : boolean;
  signal simple_obj_ref_122_inst_ack_0 : boolean;
  signal switch_stmt_124_branch_default_req_0 : boolean;
  signal switch_stmt_124_select_expr_0_req_0 : boolean;
  signal switch_stmt_124_select_expr_0_ack_0 : boolean;
  signal switch_stmt_124_select_expr_0_req_1 : boolean;
  signal switch_stmt_124_select_expr_0_ack_1 : boolean;
  signal switch_stmt_124_branch_0_req_0 : boolean;
  signal switch_stmt_124_select_expr_1_req_0 : boolean;
  signal switch_stmt_124_select_expr_1_ack_0 : boolean;
  signal switch_stmt_124_select_expr_1_req_1 : boolean;
  signal switch_stmt_124_select_expr_1_ack_1 : boolean;
  signal switch_stmt_124_branch_1_req_0 : boolean;
  signal switch_stmt_124_branch_0_ack_1 : boolean;
  signal switch_stmt_124_branch_1_ack_1 : boolean;
  signal switch_stmt_124_branch_default_ack_0 : boolean;
  signal type_cast_146_inst_req_0 : boolean;
  signal type_cast_146_inst_ack_0 : boolean;
  signal binary_150_inst_req_0 : boolean;
  signal binary_150_inst_ack_0 : boolean;
  signal binary_150_inst_req_1 : boolean;
  signal binary_150_inst_ack_1 : boolean;
  signal if_stmt_153_branch_req_0 : boolean;
  signal if_stmt_153_branch_ack_1 : boolean;
  signal if_stmt_153_branch_ack_0 : boolean;
  signal array_obj_ref_162_index_0_resize_req_0 : boolean;
  signal array_obj_ref_162_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_162_index_0_rename_req_0 : boolean;
  signal array_obj_ref_162_index_0_rename_ack_0 : boolean;
  signal array_obj_ref_162_offset_inst_req_0 : boolean;
  signal array_obj_ref_162_offset_inst_ack_0 : boolean;
  signal array_obj_ref_162_root_address_inst_req_0 : boolean;
  signal array_obj_ref_162_root_address_inst_ack_0 : boolean;
  signal addr_of_163_final_reg_req_0 : boolean;
  signal addr_of_163_final_reg_ack_0 : boolean;
  signal ptr_deref_167_base_resize_req_0 : boolean;
  signal ptr_deref_167_base_resize_ack_0 : boolean;
  signal ptr_deref_167_root_address_inst_req_0 : boolean;
  signal ptr_deref_167_root_address_inst_ack_0 : boolean;
  signal ptr_deref_167_addr_0_req_0 : boolean;
  signal ptr_deref_167_addr_0_ack_0 : boolean;
  signal phi_stmt_318_req_1 : boolean;
  signal type_cast_321_inst_req_0 : boolean;
  signal type_cast_321_inst_ack_0 : boolean;
  signal phi_stmt_318_req_0 : boolean;
  signal phi_stmt_318_ack_0 : boolean;
  signal if_stmt_175_branch_req_0 : boolean;
  signal if_stmt_175_branch_ack_1 : boolean;
  signal if_stmt_175_branch_ack_0 : boolean;
  signal binary_186_inst_req_0 : boolean;
  signal binary_186_inst_ack_0 : boolean;
  signal binary_186_inst_req_1 : boolean;
  signal binary_186_inst_ack_1 : boolean;
  signal binary_194_inst_req_0 : boolean;
  signal binary_194_inst_ack_0 : boolean;
  signal binary_194_inst_req_1 : boolean;
  signal binary_194_inst_ack_1 : boolean;
  signal array_obj_ref_198_index_0_resize_req_0 : boolean;
  signal array_obj_ref_198_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_198_index_0_rename_req_0 : boolean;
  signal array_obj_ref_198_index_0_rename_ack_0 : boolean;
  signal array_obj_ref_198_offset_inst_req_0 : boolean;
  signal array_obj_ref_198_offset_inst_ack_0 : boolean;
  signal array_obj_ref_198_root_address_inst_req_0 : boolean;
  signal array_obj_ref_198_root_address_inst_ack_0 : boolean;
  signal addr_of_199_final_reg_req_0 : boolean;
  signal addr_of_199_final_reg_ack_0 : boolean;
  signal type_cast_203_inst_req_0 : boolean;
  signal type_cast_203_inst_ack_0 : boolean;
  signal ptr_deref_206_base_resize_req_0 : boolean;
  signal ptr_deref_206_base_resize_ack_0 : boolean;
  signal ptr_deref_206_root_address_inst_req_0 : boolean;
  signal ptr_deref_206_root_address_inst_ack_0 : boolean;
  signal ptr_deref_206_addr_0_req_0 : boolean;
  signal ptr_deref_206_addr_0_ack_0 : boolean;
  signal ptr_deref_206_gather_scatter_req_0 : boolean;
  signal ptr_deref_206_gather_scatter_ack_0 : boolean;
  signal ptr_deref_206_store_0_req_0 : boolean;
  signal ptr_deref_206_store_0_ack_0 : boolean;
  signal ptr_deref_206_store_0_req_1 : boolean;
  signal ptr_deref_206_store_0_ack_1 : boolean;
  signal simple_obj_ref_216_inst_req_0 : boolean;
  signal simple_obj_ref_216_inst_ack_0 : boolean;
  signal simple_obj_ref_226_inst_req_0 : boolean;
  signal simple_obj_ref_226_inst_ack_0 : boolean;
  signal simple_obj_ref_237_inst_req_0 : boolean;
  signal simple_obj_ref_237_inst_ack_0 : boolean;
  signal simple_obj_ref_250_inst_req_0 : boolean;
  signal simple_obj_ref_250_inst_ack_0 : boolean;
  signal binary_256_inst_req_0 : boolean;
  signal binary_256_inst_ack_0 : boolean;
  signal binary_256_inst_req_1 : boolean;
  signal binary_256_inst_ack_1 : boolean;
  signal if_stmt_258_branch_req_0 : boolean;
  signal if_stmt_258_branch_ack_1 : boolean;
  signal if_stmt_258_branch_ack_0 : boolean;
  signal binary_277_inst_req_0 : boolean;
  signal binary_277_inst_ack_0 : boolean;
  signal binary_277_inst_req_1 : boolean;
  signal binary_277_inst_ack_1 : boolean;
  signal binary_283_inst_req_0 : boolean;
  signal binary_283_inst_ack_0 : boolean;
  signal binary_283_inst_req_1 : boolean;
  signal binary_283_inst_ack_1 : boolean;
  signal binary_289_inst_req_0 : boolean;
  signal binary_289_inst_ack_0 : boolean;
  signal binary_289_inst_req_1 : boolean;
  signal binary_289_inst_ack_1 : boolean;
  signal binary_294_inst_req_0 : boolean;
  signal binary_294_inst_ack_0 : boolean;
  signal binary_294_inst_req_1 : boolean;
  signal binary_294_inst_ack_1 : boolean;
  signal if_stmt_296_branch_req_0 : boolean;
  signal if_stmt_296_branch_ack_1 : boolean;
  signal if_stmt_296_branch_ack_0 : boolean;
  signal type_cast_305_inst_req_0 : boolean;
  signal type_cast_305_inst_ack_0 : boolean;
  signal binary_309_inst_req_0 : boolean;
  signal binary_309_inst_ack_0 : boolean;
  signal binary_309_inst_req_1 : boolean;
  signal binary_309_inst_ack_1 : boolean;
  signal if_stmt_311_branch_req_0 : boolean;
  signal if_stmt_311_branch_ack_1 : boolean;
  signal if_stmt_311_branch_ack_0 : boolean;
  signal array_obj_ref_328_index_0_resize_req_0 : boolean;
  signal array_obj_ref_328_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_328_index_0_rename_req_0 : boolean;
  signal array_obj_ref_328_index_0_rename_ack_0 : boolean;
  signal array_obj_ref_328_offset_inst_req_0 : boolean;
  signal array_obj_ref_328_offset_inst_ack_0 : boolean;
  signal array_obj_ref_328_root_address_inst_req_0 : boolean;
  signal array_obj_ref_328_root_address_inst_ack_0 : boolean;
  signal addr_of_329_final_reg_req_0 : boolean;
  signal addr_of_329_final_reg_ack_0 : boolean;
  signal ptr_deref_332_base_resize_req_0 : boolean;
  signal ptr_deref_332_base_resize_ack_0 : boolean;
  signal ptr_deref_332_root_address_inst_req_0 : boolean;
  signal ptr_deref_332_root_address_inst_ack_0 : boolean;
  signal ptr_deref_332_addr_0_req_0 : boolean;
  signal ptr_deref_332_addr_0_ack_0 : boolean;
  signal ptr_deref_332_gather_scatter_req_0 : boolean;
  signal ptr_deref_332_gather_scatter_ack_0 : boolean;
  signal ptr_deref_332_store_0_req_0 : boolean;
  signal ptr_deref_332_store_0_ack_0 : boolean;
  signal ptr_deref_332_store_0_req_1 : boolean;
  signal ptr_deref_332_store_0_ack_1 : boolean;
  signal type_cast_138_inst_req_0 : boolean;
  signal type_cast_138_inst_ack_0 : boolean;
  signal phi_stmt_135_req_0 : boolean;
  signal phi_stmt_135_req_1 : boolean;
  signal phi_stmt_135_ack_0 : boolean;
  signal phi_stmt_265_req_1 : boolean;
  signal type_cast_268_inst_req_0 : boolean;
  signal type_cast_268_inst_ack_0 : boolean;
  signal phi_stmt_265_req_0 : boolean;
  signal phi_stmt_265_ack_0 : boolean;
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
  free_queue_manager_CP_0: Block -- control-path 
    signal cp_elements: BooleanArray(170 downto 0);
    -- 
  begin -- 
    cp_elements(0) <= start_req_symbol;
    start_ack_symbol <= cp_elements(1);
    finAckJoin: join2 port map(pred0 => fin_req_symbol, pred1 => cp_elements(1), symbol_out => fin_ack_symbol, clk => clk, reset => reset);
    ptr_deref_76_gather_scatter_req_0 <= cp_elements(0);
    cp_elements(1) <= false; 
    cp_elements(2) <= OrReduce(cp_elements(152) & cp_elements(148));
    type_cast_146_inst_req_0 <= cp_elements(2);
    cp_elements(3) <= OrReduce(cp_elements(154) & cp_elements(49));
    array_obj_ref_162_index_0_resize_req_0 <= cp_elements(3);
    cp_elements(4) <= OrReduce(cp_elements(156) & cp_elements(73));
    binary_186_inst_req_0 <= cp_elements(4);
    cp_elements(5) <= OrReduce(cp_elements(158) & cp_elements(162));
    binary_277_inst_req_0 <= cp_elements(5);
    cp_elements(6) <= OrReduce(cp_elements(164) & cp_elements(121));
    type_cast_305_inst_req_0 <= cp_elements(6);
    cp_elements(7) <= OrReduce(cp_elements(166) & cp_elements(170));
    array_obj_ref_328_index_0_resize_req_0 <= cp_elements(7);
    cp_elements(8) <= ptr_deref_76_gather_scatter_ack_0;
    ptr_deref_76_store_0_req_0 <= cp_elements(8);
    cp_elements(9) <= ptr_deref_76_store_0_ack_0;
    ptr_deref_76_store_0_req_1 <= cp_elements(9);
    cp_elements(10) <= ptr_deref_76_store_0_ack_1;
    ptr_deref_87_gather_scatter_req_0 <= cp_elements(10);
    cp_elements(11) <= ptr_deref_87_gather_scatter_ack_0;
    ptr_deref_87_store_0_req_0 <= cp_elements(11);
    cp_elements(12) <= ptr_deref_87_store_0_ack_0;
    ptr_deref_87_store_0_req_1 <= cp_elements(12);
    cp_elements(13) <= ptr_deref_87_store_0_ack_1;
    ptr_deref_98_gather_scatter_req_0 <= cp_elements(13);
    cp_elements(14) <= ptr_deref_98_gather_scatter_ack_0;
    ptr_deref_98_store_0_req_0 <= cp_elements(14);
    cp_elements(15) <= ptr_deref_98_store_0_ack_0;
    ptr_deref_98_store_0_req_1 <= cp_elements(15);
    cp_elements(16) <= ptr_deref_98_store_0_ack_1;
    ptr_deref_109_gather_scatter_req_0 <= cp_elements(16);
    cp_elements(17) <= ptr_deref_109_gather_scatter_ack_0;
    ptr_deref_109_store_0_req_0 <= cp_elements(17);
    cp_elements(18) <= ptr_deref_109_store_0_ack_0;
    ptr_deref_109_store_0_req_1 <= cp_elements(18);
    cp_elements(19) <= ptr_deref_109_store_0_ack_1;
    cp_elements(20) <= simple_obj_ref_122_inst_ack_0;
    cp_elements(21) <= cp_elements(20);
    cp_elements(22) <= false;
    cp_elements(23) <= cp_elements(22);
    cp_elements(24) <= cp_elements(20);
    cp_elements(25) <= cp_elements(24);
    cp_elements(26) <= cp_elements(25);
    switch_stmt_124_select_expr_0_req_0 <= cp_elements(26);
    cp_elements(27) <= switch_stmt_124_select_expr_0_ack_0;
    switch_stmt_124_select_expr_0_req_1 <= cp_elements(27);
    cp_elements(28) <= switch_stmt_124_select_expr_0_ack_1;
    switch_stmt_124_branch_0_req_0 <= cp_elements(28);
    cp_elements(29) <= cp_elements(25);
    switch_stmt_124_select_expr_1_req_0 <= cp_elements(29);
    cp_elements(30) <= switch_stmt_124_select_expr_1_ack_0;
    switch_stmt_124_select_expr_1_req_1 <= cp_elements(30);
    cp_elements(31) <= switch_stmt_124_select_expr_1_ack_1;
    switch_stmt_124_branch_1_req_0 <= cp_elements(31);
    cpelement_group_32 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(31) & cp_elements(28));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(32),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    switch_stmt_124_branch_default_req_0 <= cp_elements(32);
    cp_elements(33) <= cp_elements(32);
    cp_elements(34) <= cp_elements(33);
    cp_elements(35) <= switch_stmt_124_branch_0_ack_1;
    phi_stmt_135_req_1 <= cp_elements(35);
    cp_elements(36) <= cp_elements(33);
    cp_elements(37) <= switch_stmt_124_branch_1_ack_1;
    simple_obj_ref_250_inst_req_0 <= cp_elements(37);
    cp_elements(38) <= cp_elements(33);
    cp_elements(39) <= switch_stmt_124_branch_default_ack_0;
    cp_elements(40) <= type_cast_146_inst_ack_0;
    binary_150_inst_req_0 <= cp_elements(40);
    cp_elements(41) <= binary_150_inst_ack_0;
    binary_150_inst_req_1 <= cp_elements(41);
    cp_elements(42) <= binary_150_inst_ack_1;
    cp_elements(43) <= cp_elements(42);
    cp_elements(44) <= false;
    cp_elements(45) <= cp_elements(44);
    cp_elements(46) <= cp_elements(42);
    if_stmt_153_branch_req_0 <= cp_elements(46);
    cp_elements(47) <= cp_elements(46);
    cp_elements(48) <= cp_elements(47);
    cp_elements(49) <= if_stmt_153_branch_ack_1;
    cp_elements(50) <= cp_elements(47);
    cp_elements(51) <= if_stmt_153_branch_ack_0;
    simple_obj_ref_237_inst_req_0 <= cp_elements(51);
    cp_elements(52) <= array_obj_ref_162_index_0_resize_ack_0;
    array_obj_ref_162_index_0_rename_req_0 <= cp_elements(52);
    cp_elements(53) <= array_obj_ref_162_index_0_rename_ack_0;
    array_obj_ref_162_offset_inst_req_0 <= cp_elements(53);
    cp_elements(54) <= array_obj_ref_162_offset_inst_ack_0;
    array_obj_ref_162_root_address_inst_req_0 <= cp_elements(54);
    cp_elements(55) <= array_obj_ref_162_root_address_inst_ack_0;
    addr_of_163_final_reg_req_0 <= cp_elements(55);
    cp_elements(56) <= addr_of_163_final_reg_ack_0;
    ptr_deref_167_base_resize_req_0 <= cp_elements(56);
    cp_elements(57) <= ptr_deref_167_base_resize_ack_0;
    ptr_deref_167_root_address_inst_req_0 <= cp_elements(57);
    cp_elements(58) <= ptr_deref_167_root_address_inst_ack_0;
    ptr_deref_167_addr_0_req_0 <= cp_elements(58);
    cp_elements(59) <= ptr_deref_167_addr_0_ack_0;
    ptr_deref_167_load_0_req_0 <= cp_elements(59);
    cp_elements(60) <= ptr_deref_167_load_0_ack_0;
    ptr_deref_167_load_0_req_1 <= cp_elements(60);
    cp_elements(61) <= ptr_deref_167_load_0_ack_1;
    ptr_deref_167_gather_scatter_req_0 <= cp_elements(61);
    cp_elements(62) <= ptr_deref_167_gather_scatter_ack_0;
    binary_173_inst_req_0 <= cp_elements(62);
    cp_elements(63) <= binary_173_inst_ack_0;
    binary_173_inst_req_1 <= cp_elements(63);
    cp_elements(64) <= binary_173_inst_ack_1;
    cp_elements(65) <= cp_elements(64);
    cp_elements(66) <= false;
    cp_elements(67) <= cp_elements(66);
    cp_elements(68) <= cp_elements(64);
    if_stmt_175_branch_req_0 <= cp_elements(68);
    cp_elements(69) <= cp_elements(68);
    cp_elements(70) <= cp_elements(69);
    cp_elements(71) <= if_stmt_175_branch_ack_1;
    binary_194_inst_req_0 <= cp_elements(71);
    cp_elements(72) <= cp_elements(69);
    cp_elements(73) <= if_stmt_175_branch_ack_0;
    cp_elements(74) <= binary_186_inst_ack_0;
    binary_186_inst_req_1 <= cp_elements(74);
    cp_elements(75) <= binary_186_inst_ack_1;
    type_cast_138_inst_req_0 <= cp_elements(75);
    cp_elements(76) <= binary_194_inst_ack_0;
    binary_194_inst_req_1 <= cp_elements(76);
    cp_elements(77) <= binary_194_inst_ack_1;
    array_obj_ref_198_index_0_resize_req_0 <= cp_elements(77);
    cp_elements(78) <= array_obj_ref_198_index_0_resize_ack_0;
    array_obj_ref_198_index_0_rename_req_0 <= cp_elements(78);
    cp_elements(79) <= array_obj_ref_198_index_0_rename_ack_0;
    array_obj_ref_198_offset_inst_req_0 <= cp_elements(79);
    cp_elements(80) <= array_obj_ref_198_offset_inst_ack_0;
    array_obj_ref_198_root_address_inst_req_0 <= cp_elements(80);
    cp_elements(81) <= array_obj_ref_198_root_address_inst_ack_0;
    addr_of_199_final_reg_req_0 <= cp_elements(81);
    cp_elements(82) <= addr_of_199_final_reg_ack_0;
    type_cast_203_inst_req_0 <= cp_elements(82);
    cp_elements(83) <= type_cast_203_inst_ack_0;
    ptr_deref_206_base_resize_req_0 <= cp_elements(83);
    cp_elements(84) <= ptr_deref_206_base_resize_ack_0;
    ptr_deref_206_root_address_inst_req_0 <= cp_elements(84);
    cp_elements(85) <= ptr_deref_206_root_address_inst_ack_0;
    ptr_deref_206_addr_0_req_0 <= cp_elements(85);
    cp_elements(86) <= ptr_deref_206_addr_0_ack_0;
    ptr_deref_206_gather_scatter_req_0 <= cp_elements(86);
    cp_elements(87) <= ptr_deref_206_gather_scatter_ack_0;
    ptr_deref_206_store_0_req_0 <= cp_elements(87);
    cp_elements(88) <= ptr_deref_206_store_0_ack_0;
    ptr_deref_206_store_0_req_1 <= cp_elements(88);
    cp_elements(89) <= ptr_deref_206_store_0_ack_1;
    simple_obj_ref_216_inst_req_0 <= cp_elements(89);
    cp_elements(90) <= simple_obj_ref_216_inst_ack_0;
    simple_obj_ref_226_inst_req_0 <= cp_elements(90);
    cp_elements(91) <= simple_obj_ref_226_inst_ack_0;
    cp_elements(92) <= simple_obj_ref_237_inst_ack_0;
    cp_elements(93) <= simple_obj_ref_250_inst_ack_0;
    binary_256_inst_req_0 <= cp_elements(93);
    cp_elements(94) <= binary_256_inst_ack_0;
    binary_256_inst_req_1 <= cp_elements(94);
    cp_elements(95) <= binary_256_inst_ack_1;
    cp_elements(96) <= cp_elements(95);
    cp_elements(97) <= false;
    cp_elements(98) <= cp_elements(97);
    cp_elements(99) <= cp_elements(95);
    if_stmt_258_branch_req_0 <= cp_elements(99);
    cp_elements(100) <= cp_elements(99);
    cp_elements(101) <= cp_elements(100);
    cp_elements(102) <= if_stmt_258_branch_ack_1;
    phi_stmt_265_req_1 <= cp_elements(102);
    cp_elements(103) <= cp_elements(100);
    cp_elements(104) <= if_stmt_258_branch_ack_0;
    phi_stmt_318_req_1 <= cp_elements(104);
    cp_elements(105) <= binary_277_inst_ack_0;
    binary_277_inst_req_1 <= cp_elements(105);
    cp_elements(106) <= binary_277_inst_ack_1;
    binary_283_inst_req_0 <= cp_elements(106);
    cp_elements(107) <= binary_283_inst_ack_0;
    binary_283_inst_req_1 <= cp_elements(107);
    cp_elements(108) <= binary_283_inst_ack_1;
    binary_289_inst_req_0 <= cp_elements(108);
    cp_elements(109) <= binary_289_inst_ack_0;
    binary_289_inst_req_1 <= cp_elements(109);
    cp_elements(110) <= binary_289_inst_ack_1;
    binary_294_inst_req_0 <= cp_elements(110);
    cp_elements(111) <= binary_294_inst_ack_0;
    binary_294_inst_req_1 <= cp_elements(111);
    cp_elements(112) <= binary_294_inst_ack_1;
    cp_elements(113) <= cp_elements(112);
    cp_elements(114) <= false;
    cp_elements(115) <= cp_elements(114);
    cp_elements(116) <= cp_elements(112);
    if_stmt_296_branch_req_0 <= cp_elements(116);
    cp_elements(117) <= cp_elements(116);
    cp_elements(118) <= cp_elements(117);
    cp_elements(119) <= if_stmt_296_branch_ack_1;
    type_cast_268_inst_req_0 <= cp_elements(119);
    cp_elements(120) <= cp_elements(117);
    cp_elements(121) <= if_stmt_296_branch_ack_0;
    cp_elements(122) <= type_cast_305_inst_ack_0;
    binary_309_inst_req_0 <= cp_elements(122);
    cp_elements(123) <= binary_309_inst_ack_0;
    binary_309_inst_req_1 <= cp_elements(123);
    cp_elements(124) <= binary_309_inst_ack_1;
    cp_elements(125) <= cp_elements(124);
    cp_elements(126) <= false;
    cp_elements(127) <= cp_elements(126);
    cp_elements(128) <= cp_elements(124);
    if_stmt_311_branch_req_0 <= cp_elements(128);
    cp_elements(129) <= cp_elements(128);
    cp_elements(130) <= cp_elements(129);
    cp_elements(131) <= if_stmt_311_branch_ack_1;
    type_cast_321_inst_req_0 <= cp_elements(131);
    cp_elements(132) <= cp_elements(129);
    cp_elements(133) <= if_stmt_311_branch_ack_0;
    cp_elements(134) <= array_obj_ref_328_index_0_resize_ack_0;
    array_obj_ref_328_index_0_rename_req_0 <= cp_elements(134);
    cp_elements(135) <= array_obj_ref_328_index_0_rename_ack_0;
    array_obj_ref_328_offset_inst_req_0 <= cp_elements(135);
    cp_elements(136) <= array_obj_ref_328_offset_inst_ack_0;
    array_obj_ref_328_root_address_inst_req_0 <= cp_elements(136);
    cp_elements(137) <= array_obj_ref_328_root_address_inst_ack_0;
    addr_of_329_final_reg_req_0 <= cp_elements(137);
    cp_elements(138) <= addr_of_329_final_reg_ack_0;
    ptr_deref_332_base_resize_req_0 <= cp_elements(138);
    cp_elements(139) <= ptr_deref_332_base_resize_ack_0;
    ptr_deref_332_root_address_inst_req_0 <= cp_elements(139);
    cp_elements(140) <= ptr_deref_332_root_address_inst_ack_0;
    ptr_deref_332_addr_0_req_0 <= cp_elements(140);
    cp_elements(141) <= ptr_deref_332_addr_0_ack_0;
    ptr_deref_332_gather_scatter_req_0 <= cp_elements(141);
    cp_elements(142) <= ptr_deref_332_gather_scatter_ack_0;
    ptr_deref_332_store_0_req_0 <= cp_elements(142);
    cp_elements(143) <= ptr_deref_332_store_0_ack_0;
    ptr_deref_332_store_0_req_1 <= cp_elements(143);
    cp_elements(144) <= ptr_deref_332_store_0_ack_1;
    cp_elements(145) <= OrReduce(cp_elements(19) & cp_elements(39) & cp_elements(144) & cp_elements(92) & cp_elements(91) & cp_elements(133));
    cp_elements(146) <= cp_elements(145);
    simple_obj_ref_122_inst_req_0 <= cp_elements(146);
    cp_elements(147) <= false;
    cp_elements(148) <= cp_elements(147);
    cp_elements(149) <= type_cast_138_inst_ack_0;
    phi_stmt_135_req_0 <= cp_elements(149);
    cp_elements(150) <= OrReduce(cp_elements(149) & cp_elements(35));
    cp_elements(151) <= cp_elements(150);
    cp_elements(152) <= phi_stmt_135_ack_0;
    cp_elements(153) <= false;
    cp_elements(154) <= cp_elements(153);
    cp_elements(155) <= false;
    cp_elements(156) <= cp_elements(155);
    cp_elements(157) <= false;
    cp_elements(158) <= cp_elements(157);
    cp_elements(159) <= type_cast_268_inst_ack_0;
    phi_stmt_265_req_0 <= cp_elements(159);
    cp_elements(160) <= OrReduce(cp_elements(159) & cp_elements(102));
    cp_elements(161) <= cp_elements(160);
    cp_elements(162) <= phi_stmt_265_ack_0;
    cp_elements(163) <= false;
    cp_elements(164) <= cp_elements(163);
    cp_elements(165) <= false;
    cp_elements(166) <= cp_elements(165);
    cp_elements(167) <= type_cast_321_inst_ack_0;
    phi_stmt_318_req_0 <= cp_elements(167);
    cp_elements(168) <= OrReduce(cp_elements(104) & cp_elements(167));
    cp_elements(169) <= cp_elements(168);
    cp_elements(170) <= phi_stmt_318_ack_0;
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal array_obj_ref_162_final_offset : std_logic_vector(2 downto 0);
    signal array_obj_ref_162_offset_scale_factor_0 : std_logic_vector(2 downto 0);
    signal array_obj_ref_162_resized_base_address : std_logic_vector(2 downto 0);
    signal array_obj_ref_162_root_address : std_logic_vector(2 downto 0);
    signal array_obj_ref_198_final_offset : std_logic_vector(10 downto 0);
    signal array_obj_ref_198_offset_scale_factor_0 : std_logic_vector(10 downto 0);
    signal array_obj_ref_198_resized_base_address : std_logic_vector(10 downto 0);
    signal array_obj_ref_198_root_address : std_logic_vector(10 downto 0);
    signal array_obj_ref_328_final_offset : std_logic_vector(2 downto 0);
    signal array_obj_ref_328_offset_scale_factor_0 : std_logic_vector(2 downto 0);
    signal array_obj_ref_328_resized_base_address : std_logic_vector(2 downto 0);
    signal array_obj_ref_328_root_address : std_logic_vector(2 downto 0);
    signal expr_126_wire_constant : std_logic_vector(7 downto 0);
    signal expr_126_wire_constant_cmp : std_logic_vector(0 downto 0);
    signal expr_129_wire_constant : std_logic_vector(7 downto 0);
    signal expr_129_wire_constant_cmp : std_logic_vector(0 downto 0);
    signal i3x_x044_265 : std_logic_vector(31 downto 0);
    signal i3x_x0x_xlcssa53_318 : std_logic_vector(31 downto 0);
    signal iNsTr_0_74 : std_logic_vector(31 downto 0);
    signal iNsTr_11_135 : std_logic_vector(31 downto 0);
    signal iNsTr_13_248 : std_logic_vector(31 downto 0);
    signal iNsTr_16_236 : std_logic_vector(31 downto 0);
    signal iNsTr_19_284 : std_logic_vector(31 downto 0);
    signal iNsTr_24_215 : std_logic_vector(31 downto 0);
    signal iNsTr_26_225 : std_logic_vector(31 downto 0);
    signal iNsTr_2_85 : std_logic_vector(31 downto 0);
    signal iNsTr_4_96 : std_logic_vector(31 downto 0);
    signal iNsTr_6_107 : std_logic_vector(31 downto 0);
    signal iNsTr_9_120 : std_logic_vector(31 downto 0);
    signal ptr_deref_109_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_109_wire : std_logic_vector(7 downto 0);
    signal ptr_deref_109_word_address_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_167_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_167_resized_base_address : std_logic_vector(2 downto 0);
    signal ptr_deref_167_root_address : std_logic_vector(2 downto 0);
    signal ptr_deref_167_word_address_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_167_word_offset_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_206_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_206_resized_base_address : std_logic_vector(2 downto 0);
    signal ptr_deref_206_root_address : std_logic_vector(2 downto 0);
    signal ptr_deref_206_wire : std_logic_vector(7 downto 0);
    signal ptr_deref_206_word_address_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_206_word_offset_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_332_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_332_resized_base_address : std_logic_vector(2 downto 0);
    signal ptr_deref_332_root_address : std_logic_vector(2 downto 0);
    signal ptr_deref_332_wire : std_logic_vector(7 downto 0);
    signal ptr_deref_332_word_address_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_332_word_offset_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_76_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_76_wire : std_logic_vector(7 downto 0);
    signal ptr_deref_76_word_address_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_87_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_87_wire : std_logic_vector(7 downto 0);
    signal ptr_deref_87_word_address_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_98_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_98_wire : std_logic_vector(7 downto 0);
    signal ptr_deref_98_word_address_0 : std_logic_vector(2 downto 0);
    signal simple_obj_ref_161_resized : std_logic_vector(2 downto 0);
    signal simple_obj_ref_161_scaled : std_logic_vector(2 downto 0);
    signal simple_obj_ref_197_resized : std_logic_vector(10 downto 0);
    signal simple_obj_ref_197_scaled : std_logic_vector(10 downto 0);
    signal simple_obj_ref_327_resized : std_logic_vector(2 downto 0);
    signal simple_obj_ref_327_scaled : std_logic_vector(2 downto 0);
    signal tmp10_152 : std_logic_vector(0 downto 0);
    signal tmp12_164 : std_logic_vector(31 downto 0);
    signal tmp13_168 : std_logic_vector(7 downto 0);
    signal tmp14_174 : std_logic_vector(0 downto 0);
    signal tmp16_195 : std_logic_vector(31 downto 0);
    signal tmp17_200 : std_logic_vector(31 downto 0);
    signal tmp18_204 : std_logic_vector(31 downto 0);
    signal tmp21_187 : std_logic_vector(31 downto 0);
    signal tmp28_251 : std_logic_vector(31 downto 0);
    signal tmp31_290 : std_logic_vector(31 downto 0);
    signal tmp3243_257 : std_logic_vector(0 downto 0);
    signal tmp32_295 : std_logic_vector(0 downto 0);
    signal tmp36_310 : std_logic_vector(0 downto 0);
    signal tmp38_330 : std_logic_vector(31 downto 0);
    signal tmp50_278 : std_logic_vector(31 downto 0);
    signal tmp6_123 : std_logic_vector(7 downto 0);
    signal type_cast_100_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_111_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_138_wire : std_logic_vector(31 downto 0);
    signal type_cast_141_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_146_wire : std_logic_vector(31 downto 0);
    signal type_cast_149_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_172_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_185_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_193_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_208_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_218_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_239_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_255_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_268_wire : std_logic_vector(31 downto 0);
    signal type_cast_271_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_276_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_282_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_288_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_305_wire : std_logic_vector(31 downto 0);
    signal type_cast_308_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_321_wire : std_logic_vector(31 downto 0);
    signal type_cast_324_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_334_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_78_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_89_wire_constant : std_logic_vector(7 downto 0);
    -- 
  begin -- 
    array_obj_ref_162_offset_scale_factor_0 <= "001";
    array_obj_ref_162_resized_base_address <= "000";
    array_obj_ref_198_offset_scale_factor_0 <= "00000000001";
    array_obj_ref_198_resized_base_address <= "00000000000";
    array_obj_ref_328_offset_scale_factor_0 <= "001";
    array_obj_ref_328_resized_base_address <= "000";
    expr_126_wire_constant <= "00000010";
    expr_129_wire_constant <= "00000001";
    iNsTr_0_74 <= "00000000000000000000000000000000";
    iNsTr_13_248 <= "00000000000000000000000000000000";
    iNsTr_16_236 <= "00000000000000000000000000000000";
    iNsTr_24_215 <= "00000000000000000000000000000000";
    iNsTr_26_225 <= "00000000000000000000000000000000";
    iNsTr_2_85 <= "00000000000000000000000000000001";
    iNsTr_4_96 <= "00000000000000000000000000000010";
    iNsTr_6_107 <= "00000000000000000000000000000011";
    iNsTr_9_120 <= "00000000000000000000000000000000";
    ptr_deref_109_word_address_0 <= "011";
    ptr_deref_167_word_offset_0 <= "000";
    ptr_deref_206_word_offset_0 <= "000";
    ptr_deref_332_word_offset_0 <= "000";
    ptr_deref_76_word_address_0 <= "000";
    ptr_deref_87_word_address_0 <= "001";
    ptr_deref_98_word_address_0 <= "010";
    type_cast_100_wire_constant <= "00000001";
    type_cast_111_wire_constant <= "00000001";
    type_cast_141_wire_constant <= "00000000000000000000000000000000";
    type_cast_149_wire_constant <= "00000000000000000000000000000100";
    type_cast_172_wire_constant <= "00000001";
    type_cast_185_wire_constant <= "00000000000000000000000000000001";
    type_cast_193_wire_constant <= "00000000000000000000000000001000";
    type_cast_208_wire_constant <= "00000000";
    type_cast_218_wire_constant <= "00000011";
    type_cast_239_wire_constant <= "00000100";
    type_cast_255_wire_constant <= "00000000000000000000000100000000";
    type_cast_271_wire_constant <= "00000000000000000000000000000000";
    type_cast_276_wire_constant <= "00000000000000000000000000001000";
    type_cast_282_wire_constant <= "00000000000000000000000000000001";
    type_cast_288_wire_constant <= "00000000000000000000001000000000";
    type_cast_308_wire_constant <= "00000000000000000000000000000100";
    type_cast_324_wire_constant <= "00000000000000000000000000000000";
    type_cast_334_wire_constant <= "00000001";
    type_cast_78_wire_constant <= "00000001";
    type_cast_89_wire_constant <= "00000001";
    phi_stmt_135: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_138_wire & type_cast_141_wire_constant;
      req <= phi_stmt_135_req_0 & phi_stmt_135_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_135_ack_0,
          idata => idata,
          odata => iNsTr_11_135,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_135
    phi_stmt_265: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_268_wire & type_cast_271_wire_constant;
      req <= phi_stmt_265_req_0 & phi_stmt_265_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_265_ack_0,
          idata => idata,
          odata => i3x_x044_265,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_265
    phi_stmt_318: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_321_wire & type_cast_324_wire_constant;
      req <= phi_stmt_318_req_0 & phi_stmt_318_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_318_ack_0,
          idata => idata,
          odata => i3x_x0x_xlcssa53_318,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_318
    addr_of_163_final_reg: RegisterBase --
      generic map(in_data_width => 3,out_data_width => 32, flow_through => false ) 
      port map( din => array_obj_ref_162_root_address, dout => tmp12_164, req => addr_of_163_final_reg_req_0, ack => addr_of_163_final_reg_ack_0, clk => clk, reset => reset); -- 
    addr_of_199_final_reg: RegisterBase --
      generic map(in_data_width => 11,out_data_width => 32, flow_through => false ) 
      port map( din => array_obj_ref_198_root_address, dout => tmp17_200, req => addr_of_199_final_reg_req_0, ack => addr_of_199_final_reg_ack_0, clk => clk, reset => reset); -- 
    addr_of_329_final_reg: RegisterBase --
      generic map(in_data_width => 3,out_data_width => 32, flow_through => false ) 
      port map( din => array_obj_ref_328_root_address, dout => tmp38_330, req => addr_of_329_final_reg_req_0, ack => addr_of_329_final_reg_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_162_index_0_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 3, flow_through => true ) 
      port map( din => iNsTr_11_135, dout => simple_obj_ref_161_resized, req => array_obj_ref_162_index_0_resize_req_0, ack => array_obj_ref_162_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_162_offset_inst: RegisterBase --
      generic map(in_data_width => 3,out_data_width => 3, flow_through => true ) 
      port map( din => simple_obj_ref_161_scaled, dout => array_obj_ref_162_final_offset, req => array_obj_ref_162_offset_inst_req_0, ack => array_obj_ref_162_offset_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_198_index_0_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 11, flow_through => true ) 
      port map( din => tmp16_195, dout => simple_obj_ref_197_resized, req => array_obj_ref_198_index_0_resize_req_0, ack => array_obj_ref_198_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_198_offset_inst: RegisterBase --
      generic map(in_data_width => 11,out_data_width => 11, flow_through => true ) 
      port map( din => simple_obj_ref_197_scaled, dout => array_obj_ref_198_final_offset, req => array_obj_ref_198_offset_inst_req_0, ack => array_obj_ref_198_offset_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_328_index_0_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 3, flow_through => true ) 
      port map( din => i3x_x0x_xlcssa53_318, dout => simple_obj_ref_327_resized, req => array_obj_ref_328_index_0_resize_req_0, ack => array_obj_ref_328_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_328_offset_inst: RegisterBase --
      generic map(in_data_width => 3,out_data_width => 3, flow_through => true ) 
      port map( din => simple_obj_ref_327_scaled, dout => array_obj_ref_328_final_offset, req => array_obj_ref_328_offset_inst_req_0, ack => array_obj_ref_328_offset_inst_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_167_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 3, flow_through => true ) 
      port map( din => tmp12_164, dout => ptr_deref_167_resized_base_address, req => ptr_deref_167_base_resize_req_0, ack => ptr_deref_167_base_resize_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_206_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 3, flow_through => true ) 
      port map( din => tmp12_164, dout => ptr_deref_206_resized_base_address, req => ptr_deref_206_base_resize_req_0, ack => ptr_deref_206_base_resize_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_332_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 3, flow_through => true ) 
      port map( din => tmp38_330, dout => ptr_deref_332_resized_base_address, req => ptr_deref_332_base_resize_req_0, ack => ptr_deref_332_base_resize_ack_0, clk => clk, reset => reset); -- 
    type_cast_138_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => tmp21_187, dout => type_cast_138_wire, req => type_cast_138_inst_req_0, ack => type_cast_138_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_146_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => iNsTr_11_135, dout => type_cast_146_wire, req => type_cast_146_inst_req_0, ack => type_cast_146_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_203_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => false ) 
      port map( din => tmp17_200, dout => tmp18_204, req => type_cast_203_inst_req_0, ack => type_cast_203_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_268_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => iNsTr_19_284, dout => type_cast_268_wire, req => type_cast_268_inst_req_0, ack => type_cast_268_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_305_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => iNsTr_19_284, dout => type_cast_305_wire, req => type_cast_305_inst_req_0, ack => type_cast_305_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_321_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => iNsTr_19_284, dout => type_cast_321_wire, req => type_cast_321_inst_req_0, ack => type_cast_321_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_162_index_0_rename: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      array_obj_ref_162_index_0_rename_ack_0 <= array_obj_ref_162_index_0_rename_req_0;
      aggregated_sig <= simple_obj_ref_161_resized;
      simple_obj_ref_161_scaled <= aggregated_sig(2 downto 0);
      --
    end Block;
    array_obj_ref_162_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      array_obj_ref_162_root_address_inst_ack_0 <= array_obj_ref_162_root_address_inst_req_0;
      aggregated_sig <= array_obj_ref_162_final_offset;
      array_obj_ref_162_root_address <= aggregated_sig(2 downto 0);
      --
    end Block;
    array_obj_ref_198_index_0_rename: Block -- 
      signal aggregated_sig: std_logic_vector(10 downto 0); --
    begin -- 
      array_obj_ref_198_index_0_rename_ack_0 <= array_obj_ref_198_index_0_rename_req_0;
      aggregated_sig <= simple_obj_ref_197_resized;
      simple_obj_ref_197_scaled <= aggregated_sig(10 downto 0);
      --
    end Block;
    array_obj_ref_198_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(10 downto 0); --
    begin -- 
      array_obj_ref_198_root_address_inst_ack_0 <= array_obj_ref_198_root_address_inst_req_0;
      aggregated_sig <= array_obj_ref_198_final_offset;
      array_obj_ref_198_root_address <= aggregated_sig(10 downto 0);
      --
    end Block;
    array_obj_ref_328_index_0_rename: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      array_obj_ref_328_index_0_rename_ack_0 <= array_obj_ref_328_index_0_rename_req_0;
      aggregated_sig <= simple_obj_ref_327_resized;
      simple_obj_ref_327_scaled <= aggregated_sig(2 downto 0);
      --
    end Block;
    array_obj_ref_328_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      array_obj_ref_328_root_address_inst_ack_0 <= array_obj_ref_328_root_address_inst_req_0;
      aggregated_sig <= array_obj_ref_328_final_offset;
      array_obj_ref_328_root_address <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_109_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_109_gather_scatter_ack_0 <= ptr_deref_109_gather_scatter_req_0;
      aggregated_sig <= type_cast_111_wire_constant;
      ptr_deref_109_data_0 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_167_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_167_addr_0_ack_0 <= ptr_deref_167_addr_0_req_0;
      aggregated_sig <= ptr_deref_167_root_address;
      ptr_deref_167_word_address_0 <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_167_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_167_gather_scatter_ack_0 <= ptr_deref_167_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_167_data_0;
      tmp13_168 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_167_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_167_root_address_inst_ack_0 <= ptr_deref_167_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_167_resized_base_address;
      ptr_deref_167_root_address <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_206_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_206_addr_0_ack_0 <= ptr_deref_206_addr_0_req_0;
      aggregated_sig <= ptr_deref_206_root_address;
      ptr_deref_206_word_address_0 <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_206_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_206_gather_scatter_ack_0 <= ptr_deref_206_gather_scatter_req_0;
      aggregated_sig <= type_cast_208_wire_constant;
      ptr_deref_206_data_0 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_206_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_206_root_address_inst_ack_0 <= ptr_deref_206_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_206_resized_base_address;
      ptr_deref_206_root_address <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_332_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_332_addr_0_ack_0 <= ptr_deref_332_addr_0_req_0;
      aggregated_sig <= ptr_deref_332_root_address;
      ptr_deref_332_word_address_0 <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_332_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_332_gather_scatter_ack_0 <= ptr_deref_332_gather_scatter_req_0;
      aggregated_sig <= type_cast_334_wire_constant;
      ptr_deref_332_data_0 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_332_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_332_root_address_inst_ack_0 <= ptr_deref_332_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_332_resized_base_address;
      ptr_deref_332_root_address <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_76_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_76_gather_scatter_ack_0 <= ptr_deref_76_gather_scatter_req_0;
      aggregated_sig <= type_cast_78_wire_constant;
      ptr_deref_76_data_0 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_87_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_87_gather_scatter_ack_0 <= ptr_deref_87_gather_scatter_req_0;
      aggregated_sig <= type_cast_89_wire_constant;
      ptr_deref_87_data_0 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_98_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_98_gather_scatter_ack_0 <= ptr_deref_98_gather_scatter_req_0;
      aggregated_sig <= type_cast_100_wire_constant;
      ptr_deref_98_data_0 <= aggregated_sig(7 downto 0);
      --
    end Block;
    if_stmt_153_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= tmp10_152;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_153_branch_req_0,
          ack0 => if_stmt_153_branch_ack_0,
          ack1 => if_stmt_153_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    if_stmt_175_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= tmp14_174;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_175_branch_req_0,
          ack0 => if_stmt_175_branch_ack_0,
          ack1 => if_stmt_175_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    if_stmt_258_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= tmp3243_257;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_258_branch_req_0,
          ack0 => if_stmt_258_branch_ack_0,
          ack1 => if_stmt_258_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    if_stmt_296_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= tmp32_295;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_296_branch_req_0,
          ack0 => if_stmt_296_branch_ack_0,
          ack1 => if_stmt_296_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    if_stmt_311_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= tmp36_310;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_311_branch_req_0,
          ack0 => if_stmt_311_branch_ack_0,
          ack1 => if_stmt_311_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_124_branch_0: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= expr_126_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_124_branch_0_req_0,
          ack0 => open,
          ack1 => switch_stmt_124_branch_0_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_124_branch_1: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= expr_129_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_124_branch_1_req_0,
          ack0 => open,
          ack1 => switch_stmt_124_branch_1_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_124_branch_default: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(1 downto 0);
      begin 
      condition_sig <= expr_126_wire_constant_cmp & expr_129_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 2)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_124_branch_default_req_0,
          ack0 => switch_stmt_124_branch_default_ack_0,
          ack1 => open,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : binary_150_inst binary_309_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(1 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      data_in <= type_cast_146_wire & type_cast_305_wire;
      tmp10_152 <= data_out(1 downto 1);
      tmp36_310 <= data_out(0 downto 0);
      reqL(1) <= binary_150_inst_req_0;
      reqL(0) <= binary_309_inst_req_0;
      binary_150_inst_ack_0 <= ackL(1);
      binary_309_inst_ack_0 <= ackL(0);
      reqR(1) <= binary_150_inst_req_1;
      reqR(0) <= binary_309_inst_req_1;
      binary_150_inst_ack_1 <= ackR(1);
      binary_309_inst_ack_1 <= ackR(0);
      SplitOperator: SplitOperatorShared -- 
        generic map ( -- 
          operator_id => "ApIntSlt",
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
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          no_arbitration => false,
          min_clock_period => false,
          num_reqs => 2--
        ) -- 
      port map ( reqL => reqL , ackL => ackL, reqR => reqR, ackR => ackR, dataL => data_in, dataR => data_out, clk => clk, reset => reset);
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : binary_173_inst switch_stmt_124_select_expr_1 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(15 downto 0);
      signal data_out: std_logic_vector(1 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      data_in <= tmp13_168 & tmp6_123;
      tmp14_174 <= data_out(1 downto 1);
      expr_129_wire_constant_cmp <= data_out(0 downto 0);
      reqL(1) <= binary_173_inst_req_0;
      reqL(0) <= switch_stmt_124_select_expr_1_req_0;
      binary_173_inst_ack_0 <= ackL(1);
      switch_stmt_124_select_expr_1_ack_0 <= ackL(0);
      reqR(1) <= binary_173_inst_req_1;
      reqR(0) <= switch_stmt_124_select_expr_1_req_1;
      binary_173_inst_ack_1 <= ackR(1);
      switch_stmt_124_select_expr_1_ack_1 <= ackR(0);
      SplitOperator: SplitOperatorShared -- 
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
          constant_width => 8,
          use_constant  => true,
          zero_delay => false, 
          no_arbitration => false,
          min_clock_period => false,
          num_reqs => 2--
        ) -- 
      port map ( reqL => reqL , ackL => ackL, reqR => reqR, ackR => ackR, dataL => data_in, dataR => data_out, clk => clk, reset => reset);
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : binary_186_inst 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_11_135;
      tmp21_187 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_186_inst_req_0,
          ackL => binary_186_inst_ack_0,
          reqR => binary_186_inst_req_1,
          ackR => binary_186_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : binary_194_inst 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_11_135;
      tmp16_195 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000001000",
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_194_inst_req_0,
          ackL => binary_194_inst_ack_0,
          reqR => binary_194_inst_req_1,
          ackR => binary_194_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : binary_256_inst 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp28_251;
      tmp3243_257 <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntUgt",
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
          constant_operand => "00000000000000000000000100000000",
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_256_inst_req_0,
          ackL => binary_256_inst_ack_0,
          reqR => binary_256_inst_req_1,
          ackR => binary_256_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared split operator group (5) : binary_277_inst 
    SplitOperatorGroup5: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= i3x_x044_265;
      tmp50_278 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000001000",
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_277_inst_req_0,
          ackL => binary_277_inst_ack_0,
          reqR => binary_277_inst_req_1,
          ackR => binary_277_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 5
    -- shared split operator group (6) : binary_283_inst 
    SplitOperatorGroup6: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= i3x_x044_265;
      iNsTr_19_284 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_283_inst_req_0,
          ackL => binary_283_inst_ack_0,
          reqR => binary_283_inst_req_1,
          ackR => binary_283_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 6
    -- shared split operator group (7) : binary_289_inst 
    SplitOperatorGroup7: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp50_278;
      tmp31_290 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000001000000000",
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_289_inst_req_0,
          ackL => binary_289_inst_ack_0,
          reqR => binary_289_inst_req_1,
          ackR => binary_289_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 7
    -- shared split operator group (8) : binary_294_inst 
    SplitOperatorGroup8: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp28_251 & tmp31_290;
      tmp32_295 <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntUgt",
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
          owidth => 1,
          constant_operand => "0",
          constant_width => 1,
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_294_inst_req_0,
          ackL => binary_294_inst_ack_0,
          reqR => binary_294_inst_req_1,
          ackR => binary_294_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 8
    -- shared split operator group (9) : switch_stmt_124_select_expr_0 
    SplitOperatorGroup9: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp6_123;
      expr_126_wire_constant_cmp <= data_out(0 downto 0);
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
          constant_width => 8,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => switch_stmt_124_select_expr_0_req_0,
          ackL => switch_stmt_124_select_expr_0_ack_0,
          reqR => switch_stmt_124_select_expr_0_req_1,
          ackR => switch_stmt_124_select_expr_0_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 9
    -- shared load operator group (0) : ptr_deref_167_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(2 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      -- logging on!
      process(clk)  begin -- 
        if clk'event and clk = '1' then -- 
          if ptr_deref_167_load_0_ack_1 then -- 
            assert false report " ReadMem memory_space_2 address ptr_deref_167_word_address_0 ="  &  convert_slv_to_hex_string(ptr_deref_167_word_address_0) &  " data ptr_deref_167_data_0 ="  &  convert_slv_to_hex_string(data_out(7 downto 0)) severity note; --
          end if;
          --
        end if;
        -- 
      end process;
      reqL(0) <= ptr_deref_167_load_0_req_0;
      ptr_deref_167_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_167_load_0_req_1;
      ptr_deref_167_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_167_word_address_0;
      ptr_deref_167_data_0 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 3,  num_reqs => 1,  tag_length => 3, min_clock_period => false,
        no_arbitration => false)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_2_lr_req(0),
          mack => memory_space_2_lr_ack(0),
          maddr => memory_space_2_lr_addr(2 downto 0),
          mtag => memory_space_2_lr_tag(2 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 3,  no_arbitration => false)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_2_lc_req(0),
          mack => memory_space_2_lc_ack(0),
          mdata => memory_space_2_lc_data(7 downto 0),
          mtag => memory_space_2_lc_tag(2 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- logging on!
    process(clk)  begin -- 
      if clk'event and clk = '1' then -- 
        if ptr_deref_332_store_0_ack_1 then -- 
          assert false report " WriteMem  memory_space_2 address ptr_deref_332_word_address_0 ="  &  convert_slv_to_hex_string(ptr_deref_332_word_address_0) &  " data ptr_deref_332_data_0 ="  &  convert_slv_to_hex_string(ptr_deref_332_data_0) severity note; --
        end if;
        if ptr_deref_206_store_0_ack_1 then -- 
          assert false report " WriteMem  memory_space_2 address ptr_deref_206_word_address_0 ="  &  convert_slv_to_hex_string(ptr_deref_206_word_address_0) &  " data ptr_deref_206_data_0 ="  &  convert_slv_to_hex_string(ptr_deref_206_data_0) severity note; --
        end if;
        if ptr_deref_98_store_0_ack_1 then -- 
          assert false report " WriteMem  memory_space_2 address ptr_deref_98_word_address_0 ="  &  convert_slv_to_hex_string(ptr_deref_98_word_address_0) &  " data ptr_deref_98_data_0 ="  &  convert_slv_to_hex_string(ptr_deref_98_data_0) severity note; --
        end if;
        if ptr_deref_76_store_0_ack_1 then -- 
          assert false report " WriteMem  memory_space_2 address ptr_deref_76_word_address_0 ="  &  convert_slv_to_hex_string(ptr_deref_76_word_address_0) &  " data ptr_deref_76_data_0 ="  &  convert_slv_to_hex_string(ptr_deref_76_data_0) severity note; --
        end if;
        if ptr_deref_87_store_0_ack_1 then -- 
          assert false report " WriteMem  memory_space_2 address ptr_deref_87_word_address_0 ="  &  convert_slv_to_hex_string(ptr_deref_87_word_address_0) &  " data ptr_deref_87_data_0 ="  &  convert_slv_to_hex_string(ptr_deref_87_data_0) severity note; --
        end if;
        if ptr_deref_109_store_0_ack_1 then -- 
          assert false report " WriteMem  memory_space_2 address ptr_deref_109_word_address_0 ="  &  convert_slv_to_hex_string(ptr_deref_109_word_address_0) &  " data ptr_deref_109_data_0 ="  &  convert_slv_to_hex_string(ptr_deref_109_data_0) severity note; --
        end if;
        --
      end if;
      -- 
    end process;
    -- shared store operator group (0) : ptr_deref_332_store_0 ptr_deref_206_store_0 ptr_deref_98_store_0 ptr_deref_76_store_0 ptr_deref_87_store_0 ptr_deref_109_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(17 downto 0);
      signal data_in: std_logic_vector(47 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 5 downto 0);
      -- 
    begin -- 
      reqL(5) <= ptr_deref_332_store_0_req_0;
      reqL(4) <= ptr_deref_206_store_0_req_0;
      reqL(3) <= ptr_deref_98_store_0_req_0;
      reqL(2) <= ptr_deref_76_store_0_req_0;
      reqL(1) <= ptr_deref_87_store_0_req_0;
      reqL(0) <= ptr_deref_109_store_0_req_0;
      ptr_deref_332_store_0_ack_0 <= ackL(5);
      ptr_deref_206_store_0_ack_0 <= ackL(4);
      ptr_deref_98_store_0_ack_0 <= ackL(3);
      ptr_deref_76_store_0_ack_0 <= ackL(2);
      ptr_deref_87_store_0_ack_0 <= ackL(1);
      ptr_deref_109_store_0_ack_0 <= ackL(0);
      reqR(5) <= ptr_deref_332_store_0_req_1;
      reqR(4) <= ptr_deref_206_store_0_req_1;
      reqR(3) <= ptr_deref_98_store_0_req_1;
      reqR(2) <= ptr_deref_76_store_0_req_1;
      reqR(1) <= ptr_deref_87_store_0_req_1;
      reqR(0) <= ptr_deref_109_store_0_req_1;
      ptr_deref_332_store_0_ack_1 <= ackR(5);
      ptr_deref_206_store_0_ack_1 <= ackR(4);
      ptr_deref_98_store_0_ack_1 <= ackR(3);
      ptr_deref_76_store_0_ack_1 <= ackR(2);
      ptr_deref_87_store_0_ack_1 <= ackR(1);
      ptr_deref_109_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_332_word_address_0 & ptr_deref_206_word_address_0 & ptr_deref_98_word_address_0 & ptr_deref_76_word_address_0 & ptr_deref_87_word_address_0 & ptr_deref_109_word_address_0;
      data_in <= ptr_deref_332_data_0 & ptr_deref_206_data_0 & ptr_deref_98_data_0 & ptr_deref_76_data_0 & ptr_deref_87_data_0 & ptr_deref_109_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 3,
        data_width => 8,
        num_reqs => 6,
        tag_length => 3,
        min_clock_period => false,
        no_arbitration => false)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_2_sr_req(0),
          mack => memory_space_2_sr_ack(0),
          maddr => memory_space_2_sr_addr(2 downto 0),
          mdata => memory_space_2_sr_data(7 downto 0),
          mtag => memory_space_2_sr_tag(2 downto 0),
          clk => clk, reset => reset -- 
        );--
      StoreComplete: StoreCompleteShared -- 
        generic map ( -- 
          num_reqs => 6,
          tag_length => 3 -- 
        )
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          mreq => memory_space_2_sc_req(0),
          mack => memory_space_2_sc_ack(0),
          mtag => memory_space_2_sc_tag(2 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 0
    -- shared inport operator group (0) : simple_obj_ref_122_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      -- logging on!
      process(clk)  begin -- 
        if clk'event and clk = '1' then -- 
          if simple_obj_ref_122_inst_ack_0 then -- 
            assert false report " ReadPipe free_queue_request to wire tmp6_123 value="  &  convert_slv_to_hex_string(data_out(7 downto 0))  severity note; --
          end if;
          --
        end if;
        -- 
      end process;
      req(0) <= simple_obj_ref_122_inst_req_0;
      simple_obj_ref_122_inst_ack_0 <= ack(0);
      tmp6_123 <= data_out(7 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 8,  num_reqs => 1,  no_arbitration => false)
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
    -- shared inport operator group (1) : simple_obj_ref_250_inst 
    InportGroup1: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      -- logging on!
      process(clk)  begin -- 
        if clk'event and clk = '1' then -- 
          if simple_obj_ref_250_inst_ack_0 then -- 
            assert false report " ReadPipe free_queue_put to wire tmp28_251 value="  &  convert_slv_to_hex_string(data_out(31 downto 0))  severity note; --
          end if;
          --
        end if;
        -- 
      end process;
      req(0) <= simple_obj_ref_250_inst_req_0;
      simple_obj_ref_250_inst_ack_0 <= ack(0);
      tmp28_251 <= data_out(31 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => false)
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
    -- logging on!
    process(clk)  begin -- 
      if clk'event and clk = '1' then -- 
        if simple_obj_ref_216_inst_ack_0 then -- 
          assert false report " WritePipe free_queue_ack from wire type_cast_218_wire_constant value="  &  convert_slv_to_hex_string(type_cast_218_wire_constant) severity note; --
        end if;
        if simple_obj_ref_237_inst_ack_0 then -- 
          assert false report " WritePipe free_queue_ack from wire type_cast_239_wire_constant value="  &  convert_slv_to_hex_string(type_cast_239_wire_constant) severity note; --
        end if;
        --
      end if;
      -- 
    end process;
    -- shared outport operator group (0) : simple_obj_ref_216_inst simple_obj_ref_237_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(15 downto 0);
      signal req, ack : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      req(1) <= simple_obj_ref_216_inst_req_0;
      req(0) <= simple_obj_ref_237_inst_req_0;
      simple_obj_ref_216_inst_ack_0 <= ack(1);
      simple_obj_ref_237_inst_ack_0 <= ack(0);
      data_in <= type_cast_218_wire_constant & type_cast_239_wire_constant;
      outport: OutputPort -- 
        generic map ( data_width => 8,  num_reqs => 2,  no_arbitration => false)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => free_queue_ack_pipe_write_req(0),
          oack => free_queue_ack_pipe_write_ack(0),
          odata => free_queue_ack_pipe_write_data(7 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    -- logging on!
    process(clk)  begin -- 
      if clk'event and clk = '1' then -- 
        if simple_obj_ref_226_inst_ack_0 then -- 
          assert false report " WritePipe free_queue_get from wire tmp18_204 value="  &  convert_slv_to_hex_string(tmp18_204) severity note; --
        end if;
        --
      end if;
      -- 
    end process;
    -- shared outport operator group (1) : simple_obj_ref_226_inst 
    OutportGroup1: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_226_inst_req_0;
      simple_obj_ref_226_inst_ack_0 <= ack(0);
      data_in <= tmp18_204;
      outport: OutputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => false)
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
entity output_port_lookup is -- 
  generic (tag_length : integer); 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic;
    op_lut_ctrl_pipe_read_req : out  std_logic_vector(0 downto 0);
    op_lut_ctrl_pipe_read_ack : in   std_logic_vector(0 downto 0);
    op_lut_ctrl_pipe_read_data : in   std_logic_vector(7 downto 0);
    op_lut_data_pipe_read_req : out  std_logic_vector(0 downto 0);
    op_lut_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
    op_lut_data_pipe_read_data : in   std_logic_vector(63 downto 0);
    out_ctrl_pipe_write_req : out  std_logic_vector(0 downto 0);
    out_ctrl_pipe_write_ack : in   std_logic_vector(0 downto 0);
    out_ctrl_pipe_write_data : out  std_logic_vector(7 downto 0);
    out_data_pipe_write_req : out  std_logic_vector(0 downto 0);
    out_data_pipe_write_ack : in   std_logic_vector(0 downto 0);
    out_data_pipe_write_data : out  std_logic_vector(63 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
  );
  -- 
end entity output_port_lookup;
architecture Default of output_port_lookup is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal start_req_symbol: Boolean;
  signal start_ack_symbol: Boolean;
  signal fin_req_symbol: Boolean;
  signal fin_ack_symbol: Boolean;
  signal tag_push, tag_pop: std_logic; 
  signal start_ack_sig, fin_ack_sig: std_logic; 
  -- output port buffer signals
  signal output_port_lookup_CP_1051_start: Boolean;
  -- links between control-path and data-path
  signal phi_stmt_458_req_0 : boolean;
  signal simple_obj_ref_471_inst_req_0 : boolean;
  signal binary_415_inst_ack_0 : boolean;
  signal if_stmt_367_branch_ack_1 : boolean;
  signal binary_394_inst_req_1 : boolean;
  signal binary_394_inst_ack_1 : boolean;
  signal binary_378_inst_ack_0 : boolean;
  signal type_cast_437_inst_ack_0 : boolean;
  signal binary_378_inst_req_0 : boolean;
  signal binary_388_inst_ack_0 : boolean;
  signal binary_388_inst_ack_1 : boolean;
  signal binary_449_inst_req_0 : boolean;
  signal binary_449_inst_ack_0 : boolean;
  signal binary_409_inst_req_1 : boolean;
  signal binary_409_inst_ack_1 : boolean;
  signal phi_stmt_458_ack_0 : boolean;
  signal binary_378_inst_req_1 : boolean;
  signal type_cast_382_inst_req_0 : boolean;
  signal binary_415_inst_req_0 : boolean;
  signal binary_443_inst_req_0 : boolean;
  signal binary_443_inst_ack_0 : boolean;
  signal binary_443_inst_req_1 : boolean;
  signal binary_443_inst_ack_1 : boolean;
  signal type_cast_382_inst_ack_0 : boolean;
  signal binary_427_inst_req_0 : boolean;
  signal binary_388_inst_req_0 : boolean;
  signal phi_stmt_458_req_1 : boolean;
  signal binary_400_inst_req_0 : boolean;
  signal binary_449_inst_req_1 : boolean;
  signal binary_449_inst_ack_1 : boolean;
  signal binary_378_inst_ack_1 : boolean;
  signal binary_415_inst_ack_1 : boolean;
  signal binary_454_inst_req_0 : boolean;
  signal binary_454_inst_ack_0 : boolean;
  signal binary_400_inst_ack_0 : boolean;
  signal binary_415_inst_req_1 : boolean;
  signal binary_454_inst_req_1 : boolean;
  signal binary_454_inst_ack_1 : boolean;
  signal binary_400_inst_req_1 : boolean;
  signal ternary_433_inst_ack_0 : boolean;
  signal binary_400_inst_ack_1 : boolean;
  signal if_stmt_367_branch_ack_0 : boolean;
  signal type_cast_463_inst_req_0 : boolean;
  signal binary_388_inst_req_1 : boolean;
  signal type_cast_463_inst_ack_0 : boolean;
  signal type_cast_461_inst_req_0 : boolean;
  signal binary_409_inst_ack_0 : boolean;
  signal type_cast_461_inst_ack_0 : boolean;
  signal ternary_433_inst_req_0 : boolean;
  signal type_cast_405_inst_req_0 : boolean;
  signal binary_427_inst_ack_0 : boolean;
  signal type_cast_405_inst_ack_0 : boolean;
  signal binary_409_inst_req_0 : boolean;
  signal type_cast_437_inst_req_0 : boolean;
  signal binary_427_inst_req_1 : boolean;
  signal binary_427_inst_ack_1 : boolean;
  signal binary_421_inst_ack_1 : boolean;
  signal binary_421_inst_req_1 : boolean;
  signal binary_421_inst_ack_0 : boolean;
  signal binary_421_inst_req_0 : boolean;
  signal simple_obj_ref_471_inst_ack_0 : boolean;
  signal simple_obj_ref_480_inst_ack_0 : boolean;
  signal simple_obj_ref_480_inst_req_0 : boolean;
  signal binary_394_inst_ack_0 : boolean;
  signal binary_394_inst_req_0 : boolean;
  signal simple_obj_ref_350_inst_req_0 : boolean;
  signal simple_obj_ref_350_inst_ack_0 : boolean;
  signal simple_obj_ref_359_inst_req_0 : boolean;
  signal simple_obj_ref_359_inst_ack_0 : boolean;
  signal binary_365_inst_req_0 : boolean;
  signal binary_365_inst_ack_0 : boolean;
  signal binary_365_inst_req_1 : boolean;
  signal binary_365_inst_ack_1 : boolean;
  signal if_stmt_367_branch_req_0 : boolean;
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
  output_port_lookup_CP_1051: Block -- control-path 
    signal cp_elements: BooleanArray(58 downto 0);
    -- 
  begin -- 
    cp_elements(0) <= start_req_symbol;
    start_ack_symbol <= cp_elements(1);
    finAckJoin: join2 port map(pred0 => fin_req_symbol, pred1 => cp_elements(1), symbol_out => fin_ack_symbol, clk => clk, reset => reset);
    cp_elements(1) <= false; 
    cp_elements(2) <= OrReduce(cp_elements(13) & cp_elements(47));
    binary_378_inst_req_0 <= cp_elements(2);
    cp_elements(3) <= simple_obj_ref_350_inst_ack_0;
    simple_obj_ref_359_inst_req_0 <= cp_elements(3);
    cp_elements(4) <= simple_obj_ref_359_inst_ack_0;
    binary_365_inst_req_0 <= cp_elements(4);
    cp_elements(5) <= binary_365_inst_ack_0;
    binary_365_inst_req_1 <= cp_elements(5);
    cp_elements(6) <= binary_365_inst_ack_1;
    cp_elements(7) <= cp_elements(6);
    cp_elements(8) <= false;
    cp_elements(9) <= cp_elements(8);
    cp_elements(10) <= cp_elements(6);
    if_stmt_367_branch_req_0 <= cp_elements(10);
    cp_elements(11) <= cp_elements(10);
    cp_elements(12) <= cp_elements(11);
    cp_elements(13) <= if_stmt_367_branch_ack_1;
    cp_elements(14) <= cp_elements(11);
    cp_elements(15) <= if_stmt_367_branch_ack_0;
    cp_elements(16) <= binary_378_inst_ack_0;
    binary_378_inst_req_1 <= cp_elements(16);
    cp_elements(17) <= binary_378_inst_ack_1;
    type_cast_382_inst_req_0 <= cp_elements(17);
    cp_elements(18) <= type_cast_382_inst_ack_0;
    binary_388_inst_req_0 <= cp_elements(18);
    cp_elements(19) <= binary_388_inst_ack_0;
    binary_388_inst_req_1 <= cp_elements(19);
    cp_elements(20) <= binary_388_inst_ack_1;
    binary_394_inst_req_0 <= cp_elements(20);
    cp_elements(21) <= binary_394_inst_ack_0;
    binary_394_inst_req_1 <= cp_elements(21);
    cp_elements(22) <= binary_394_inst_ack_1;
    binary_400_inst_req_0 <= cp_elements(22);
    cp_elements(23) <= binary_400_inst_ack_0;
    binary_400_inst_req_1 <= cp_elements(23);
    cp_elements(24) <= binary_400_inst_ack_1;
    type_cast_405_inst_req_0 <= cp_elements(24);
    cp_elements(25) <= type_cast_405_inst_ack_0;
    binary_409_inst_req_0 <= cp_elements(25);
    cp_elements(26) <= binary_409_inst_ack_0;
    binary_409_inst_req_1 <= cp_elements(26);
    cp_elements(27) <= binary_409_inst_ack_1;
    binary_415_inst_req_0 <= cp_elements(27);
    cp_elements(28) <= binary_415_inst_ack_0;
    binary_415_inst_req_1 <= cp_elements(28);
    cp_elements(29) <= binary_415_inst_ack_1;
    binary_421_inst_req_0 <= cp_elements(29);
    cp_elements(30) <= binary_421_inst_ack_0;
    binary_421_inst_req_1 <= cp_elements(30);
    cp_elements(31) <= binary_421_inst_ack_1;
    binary_427_inst_req_0 <= cp_elements(31);
    cp_elements(32) <= binary_427_inst_ack_0;
    binary_427_inst_req_1 <= cp_elements(32);
    cp_elements(33) <= binary_427_inst_ack_1;
    ternary_433_inst_req_0 <= cp_elements(33);
    cp_elements(34) <= ternary_433_inst_ack_0;
    type_cast_437_inst_req_0 <= cp_elements(34);
    cp_elements(35) <= type_cast_437_inst_ack_0;
    binary_443_inst_req_0 <= cp_elements(35);
    cp_elements(36) <= binary_443_inst_ack_0;
    binary_443_inst_req_1 <= cp_elements(36);
    cp_elements(37) <= binary_443_inst_ack_1;
    binary_449_inst_req_0 <= cp_elements(37);
    cp_elements(38) <= binary_449_inst_ack_0;
    binary_449_inst_req_1 <= cp_elements(38);
    cp_elements(39) <= binary_449_inst_ack_1;
    binary_454_inst_req_0 <= cp_elements(39);
    cp_elements(40) <= binary_454_inst_ack_0;
    binary_454_inst_req_1 <= cp_elements(40);
    cp_elements(41) <= binary_454_inst_ack_1;
    cp_elements(42) <= simple_obj_ref_471_inst_ack_0;
    simple_obj_ref_480_inst_req_0 <= cp_elements(42);
    cp_elements(43) <= simple_obj_ref_480_inst_ack_0;
    cp_elements(44) <= OrReduce(cp_elements(0) & cp_elements(43));
    cp_elements(45) <= cp_elements(44);
    simple_obj_ref_350_inst_req_0 <= cp_elements(45);
    cp_elements(46) <= false;
    cp_elements(47) <= cp_elements(46);
    cp_elements(48) <= cp_elements(15);
    cp_elements(49) <= cp_elements(15);
    type_cast_463_inst_req_0 <= cp_elements(49);
    cp_elements(50) <= type_cast_463_inst_ack_0;
    cpelement_group_51 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(48) & cp_elements(50));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(51),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_458_req_1 <= cp_elements(51);
    cp_elements(52) <= cp_elements(41);
    type_cast_461_inst_req_0 <= cp_elements(52);
    cp_elements(53) <= type_cast_461_inst_ack_0;
    cp_elements(54) <= cp_elements(41);
    cpelement_group_55 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(53) & cp_elements(54));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(55),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_458_req_0 <= cp_elements(55);
    cp_elements(56) <= OrReduce(cp_elements(51) & cp_elements(55));
    cp_elements(57) <= cp_elements(56);
    cp_elements(58) <= phi_stmt_458_ack_0;
    simple_obj_ref_471_inst_req_0 <= cp_elements(58);
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal datax_x0_458 : std_logic_vector(63 downto 0);
    signal iNsTr_1_348 : std_logic_vector(31 downto 0);
    signal iNsTr_2_357 : std_logic_vector(31 downto 0);
    signal iNsTr_5_470 : std_logic_vector(31 downto 0);
    signal iNsTr_7_479 : std_logic_vector(31 downto 0);
    signal tmp10_410 : std_logic_vector(0 downto 0);
    signal tmp11_416 : std_logic_vector(31 downto 0);
    signal tmp12_422 : std_logic_vector(31 downto 0);
    signal tmp13_428 : std_logic_vector(31 downto 0);
    signal tmp14_434 : std_logic_vector(31 downto 0);
    signal tmp15_438 : std_logic_vector(63 downto 0);
    signal tmp16_444 : std_logic_vector(63 downto 0);
    signal tmp17_450 : std_logic_vector(63 downto 0);
    signal tmp18_455 : std_logic_vector(63 downto 0);
    signal tmp2_351 : std_logic_vector(7 downto 0);
    signal tmp3_360 : std_logic_vector(63 downto 0);
    signal tmp4_366 : std_logic_vector(0 downto 0);
    signal tmp6_379 : std_logic_vector(63 downto 0);
    signal tmp7_389 : std_logic_vector(31 downto 0);
    signal tmp8_395 : std_logic_vector(31 downto 0);
    signal tmp9_401 : std_logic_vector(63 downto 0);
    signal tmp_383 : std_logic_vector(31 downto 0);
    signal type_cast_364_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_377_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_387_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_392_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_399_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_405_wire : std_logic_vector(63 downto 0);
    signal type_cast_408_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_414_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_420_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_426_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_442_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_448_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_461_wire : std_logic_vector(63 downto 0);
    signal type_cast_463_wire : std_logic_vector(63 downto 0);
    -- 
  begin -- 
    iNsTr_1_348 <= "00000000000000000000000000000000";
    iNsTr_2_357 <= "00000000000000000000000000000000";
    iNsTr_5_470 <= "00000000000000000000000000000000";
    iNsTr_7_479 <= "00000000000000000000000000000000";
    type_cast_364_wire_constant <= "11111111";
    type_cast_377_wire_constant <= "0000000000000000000000000000000000000000000000000000000000010000";
    type_cast_387_wire_constant <= "00000000000000001111111111111111";
    type_cast_392_wire_constant <= "00000000000000000000000000000001";
    type_cast_399_wire_constant <= "0000000000000000000000000000000000000000000000000000000000000001";
    type_cast_408_wire_constant <= "0000000000000000000000000000000000000000000000000000000000000000";
    type_cast_414_wire_constant <= "00000000000000000000000000000001";
    type_cast_420_wire_constant <= "00000000000000000111111111111111";
    type_cast_426_wire_constant <= "00000000000000000000000000000001";
    type_cast_442_wire_constant <= "0000000000000000111111111111111111111111111111111111111111111111";
    type_cast_448_wire_constant <= "0000000000000000000000000000000000000000000000000000000000110000";
    phi_stmt_458: Block -- phi operator 
      signal idata: std_logic_vector(127 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_461_wire & type_cast_463_wire;
      req <= phi_stmt_458_req_0 & phi_stmt_458_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 64) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_458_ack_0,
          idata => idata,
          odata => datax_x0_458,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_458
    ternary_433_inst: SelectBase generic map(data_width => 32) -- 
      port map( x => tmp12_422, y => tmp13_428, sel => tmp10_410, z => tmp14_434, req => ternary_433_inst_req_0, ack => ternary_433_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_382_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 32, flow_through => false ) 
      port map( din => tmp6_379, dout => tmp_383, req => type_cast_382_inst_req_0, ack => type_cast_382_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_405_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => tmp9_401, dout => type_cast_405_wire, req => type_cast_405_inst_req_0, ack => type_cast_405_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_437_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 64, flow_through => false ) 
      port map( din => tmp14_434, dout => tmp15_438, req => type_cast_437_inst_req_0, ack => type_cast_437_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_461_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => tmp18_455, dout => type_cast_461_wire, req => type_cast_461_inst_req_0, ack => type_cast_461_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_463_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => tmp3_360, dout => type_cast_463_wire, req => type_cast_463_inst_req_0, ack => type_cast_463_inst_ack_0, clk => clk, reset => reset); -- 
    if_stmt_367_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= tmp4_366;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_367_branch_req_0,
          ack0 => if_stmt_367_branch_ack_0,
          ack1 => if_stmt_367_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : binary_365_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp2_351;
      tmp4_366 <= data_out(0 downto 0);
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
          constant_operand => "11111111",
          constant_width => 8,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_365_inst_req_0,
          ackL => binary_365_inst_ack_0,
          reqR => binary_365_inst_req_1,
          ackR => binary_365_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : binary_378_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp3_360;
      tmp6_379 <= data_out(63 downto 0);
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
          constant_width => 64,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_378_inst_req_0,
          ackL => binary_378_inst_ack_0,
          reqR => binary_378_inst_req_1,
          ackR => binary_378_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : binary_388_inst 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp_383;
      tmp7_389 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAnd",
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
          constant_operand => "00000000000000001111111111111111",
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_388_inst_req_0,
          ackL => binary_388_inst_ack_0,
          reqR => binary_388_inst_req_1,
          ackR => binary_388_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : binary_394_inst 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= type_cast_392_wire_constant & tmp7_389;
      tmp8_395 <= data_out(31 downto 0);
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
          iwidth_2      => 32, 
          num_inputs    => 2,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 32,
          constant_operand => "0",
          constant_width => 1,
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_394_inst_req_0,
          ackL => binary_394_inst_ack_0,
          reqR => binary_394_inst_req_1,
          ackR => binary_394_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : binary_400_inst 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp6_379;
      tmp9_401 <= data_out(63 downto 0);
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
          constant_operand => "0000000000000000000000000000000000000000000000000000000000000001",
          constant_width => 64,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_400_inst_req_0,
          ackL => binary_400_inst_ack_0,
          reqR => binary_400_inst_req_1,
          ackR => binary_400_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared split operator group (5) : binary_409_inst 
    SplitOperatorGroup5: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= type_cast_405_wire;
      tmp10_410 <= data_out(0 downto 0);
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
          constant_width => 64,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_409_inst_req_0,
          ackL => binary_409_inst_ack_0,
          reqR => binary_409_inst_req_1,
          ackR => binary_409_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 5
    -- shared split operator group (6) : binary_415_inst 
    SplitOperatorGroup6: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp8_395;
      tmp11_416 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntLSHR",
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
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_415_inst_req_0,
          ackL => binary_415_inst_ack_0,
          reqR => binary_415_inst_req_1,
          ackR => binary_415_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 6
    -- shared split operator group (7) : binary_421_inst 
    SplitOperatorGroup7: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp11_416;
      tmp12_422 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAnd",
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
          constant_operand => "00000000000000000111111111111111",
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_421_inst_req_0,
          ackL => binary_421_inst_ack_0,
          reqR => binary_421_inst_req_1,
          ackR => binary_421_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 7
    -- shared split operator group (8) : binary_427_inst 
    SplitOperatorGroup8: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp8_395;
      tmp13_428 <= data_out(31 downto 0);
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
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_427_inst_req_0,
          ackL => binary_427_inst_ack_0,
          reqR => binary_427_inst_req_1,
          ackR => binary_427_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 8
    -- shared split operator group (9) : binary_443_inst 
    SplitOperatorGroup9: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp3_360;
      tmp16_444 <= data_out(63 downto 0);
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
          constant_width => 64,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_443_inst_req_0,
          ackL => binary_443_inst_ack_0,
          reqR => binary_443_inst_req_1,
          ackR => binary_443_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 9
    -- shared split operator group (10) : binary_449_inst 
    SplitOperatorGroup10: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp15_438;
      tmp17_450 <= data_out(63 downto 0);
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
          constant_width => 64,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_449_inst_req_0,
          ackL => binary_449_inst_ack_0,
          reqR => binary_449_inst_req_1,
          ackR => binary_449_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 10
    -- shared split operator group (11) : binary_454_inst 
    SplitOperatorGroup11: Block -- 
      signal data_in: std_logic_vector(127 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp17_450 & tmp16_444;
      tmp18_455 <= data_out(63 downto 0);
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
          constant_width => 1,
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_454_inst_req_0,
          ackL => binary_454_inst_ack_0,
          reqR => binary_454_inst_req_1,
          ackR => binary_454_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 11
    -- shared inport operator group (0) : simple_obj_ref_350_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      -- logging on!
      process(clk)  begin -- 
        if clk'event and clk = '1' then -- 
          if simple_obj_ref_350_inst_ack_0 then -- 
            assert false report " ReadPipe op_lut_ctrl to wire tmp2_351 value="  &  convert_slv_to_hex_string(data_out(7 downto 0))  severity note; --
          end if;
          --
        end if;
        -- 
      end process;
      req(0) <= simple_obj_ref_350_inst_req_0;
      simple_obj_ref_350_inst_ack_0 <= ack(0);
      tmp2_351 <= data_out(7 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 8,  num_reqs => 1,  no_arbitration => false)
        port map (-- 
          req => req , 
          ack => ack , 
          data => data_out, 
          oreq => op_lut_ctrl_pipe_read_req(0),
          oack => op_lut_ctrl_pipe_read_ack(0),
          odata => op_lut_ctrl_pipe_read_data(7 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared inport operator group (1) : simple_obj_ref_359_inst 
    InportGroup1: Block -- 
      signal data_out: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      -- logging on!
      process(clk)  begin -- 
        if clk'event and clk = '1' then -- 
          if simple_obj_ref_359_inst_ack_0 then -- 
            assert false report " ReadPipe op_lut_data to wire tmp3_360 value="  &  convert_slv_to_hex_string(data_out(63 downto 0))  severity note; --
          end if;
          --
        end if;
        -- 
      end process;
      req(0) <= simple_obj_ref_359_inst_req_0;
      simple_obj_ref_359_inst_ack_0 <= ack(0);
      tmp3_360 <= data_out(63 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 64,  num_reqs => 1,  no_arbitration => false)
        port map (-- 
          req => req , 
          ack => ack , 
          data => data_out, 
          oreq => op_lut_data_pipe_read_req(0),
          oack => op_lut_data_pipe_read_ack(0),
          odata => op_lut_data_pipe_read_data(63 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 1
    -- logging on!
    process(clk)  begin -- 
      if clk'event and clk = '1' then -- 
        if simple_obj_ref_471_inst_ack_0 then -- 
          assert false report " WritePipe out_ctrl from wire tmp2_351 value="  &  convert_slv_to_hex_string(tmp2_351) severity note; --
        end if;
        --
      end if;
      -- 
    end process;
    -- shared outport operator group (0) : simple_obj_ref_471_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_471_inst_req_0;
      simple_obj_ref_471_inst_ack_0 <= ack(0);
      data_in <= tmp2_351;
      outport: OutputPort -- 
        generic map ( data_width => 8,  num_reqs => 1,  no_arbitration => false)
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
    -- logging on!
    process(clk)  begin -- 
      if clk'event and clk = '1' then -- 
        if simple_obj_ref_480_inst_ack_0 then -- 
          assert false report " WritePipe out_data from wire datax_x0_458 value="  &  convert_slv_to_hex_string(datax_x0_458) severity note; --
        end if;
        --
      end if;
      -- 
    end process;
    -- shared outport operator group (1) : simple_obj_ref_480_inst 
    OutportGroup1: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_480_inst_req_0;
      simple_obj_ref_480_inst_ack_0 <= ack(0);
      data_in <= datax_x0_458;
      outport: OutputPort -- 
        generic map ( data_width => 64,  num_reqs => 1,  no_arbitration => false)
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
entity wrapper_input is -- 
  generic (tag_length : integer); 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic;
    memory_space_3_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_3_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_3_sr_addr : out  std_logic_vector(10 downto 0);
    memory_space_3_sr_data : out  std_logic_vector(63 downto 0);
    memory_space_3_sr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_3_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_3_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_3_sc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_1_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_1_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_sr_addr : out  std_logic_vector(3 downto 0);
    memory_space_1_sr_data : out  std_logic_vector(7 downto 0);
    memory_space_1_sr_tag :  out  std_logic_vector(0 downto 0);
    memory_space_1_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_1_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_sc_tag :  in  std_logic_vector(0 downto 0);
    free_queue_ack_pipe_read_req : out  std_logic_vector(0 downto 0);
    free_queue_ack_pipe_read_ack : in   std_logic_vector(0 downto 0);
    free_queue_ack_pipe_read_data : in   std_logic_vector(7 downto 0);
    free_queue_get_pipe_read_req : out  std_logic_vector(0 downto 0);
    free_queue_get_pipe_read_ack : in   std_logic_vector(0 downto 0);
    free_queue_get_pipe_read_data : in   std_logic_vector(31 downto 0);
    in_ctrl_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_ctrl_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_ctrl_pipe_read_data : in   std_logic_vector(7 downto 0);
    in_data_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_data_pipe_read_data : in   std_logic_vector(63 downto 0);
    free_queue_request_pipe_write_req : out  std_logic_vector(0 downto 0);
    free_queue_request_pipe_write_ack : in   std_logic_vector(0 downto 0);
    free_queue_request_pipe_write_data : out  std_logic_vector(7 downto 0);
    midpipe_pipe_write_req : out  std_logic_vector(0 downto 0);
    midpipe_pipe_write_ack : in   std_logic_vector(0 downto 0);
    midpipe_pipe_write_data : out  std_logic_vector(31 downto 0);
    last_ctrl_pipe_write_req : out  std_logic_vector(0 downto 0);
    last_ctrl_pipe_write_ack : in   std_logic_vector(0 downto 0);
    last_ctrl_pipe_write_data : out  std_logic_vector(7 downto 0);
    pkt_length_pipe_write_req : out  std_logic_vector(0 downto 0);
    pkt_length_pipe_write_ack : in   std_logic_vector(0 downto 0);
    pkt_length_pipe_write_data : out  std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
  );
  -- 
end entity wrapper_input;
architecture Default of wrapper_input is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal start_req_symbol: Boolean;
  signal start_ack_symbol: Boolean;
  signal fin_req_symbol: Boolean;
  signal fin_ack_symbol: Boolean;
  signal tag_push, tag_pop: std_logic; 
  signal start_ack_sig, fin_ack_sig: std_logic; 
  -- output port buffer signals
  signal wrapper_input_CP_1437_start: Boolean;
  -- links between control-path and data-path
  signal simple_obj_ref_518_inst_ack_0 : boolean;
  signal simple_obj_ref_518_inst_req_0 : boolean;
  signal simple_obj_ref_564_inst_req_0 : boolean;
  signal type_cast_545_inst_req_0 : boolean;
  signal type_cast_545_inst_ack_0 : boolean;
  signal simple_obj_ref_564_inst_ack_0 : boolean;
  signal simple_obj_ref_540_inst_req_0 : boolean;
  signal simple_obj_ref_540_inst_ack_0 : boolean;
  signal if_stmt_526_branch_req_0 : boolean;
  signal ptr_deref_495_store_0_req_1 : boolean;
  signal if_stmt_526_branch_ack_1 : boolean;
  signal ptr_deref_495_store_0_req_0 : boolean;
  signal simple_obj_ref_507_inst_req_0 : boolean;
  signal simple_obj_ref_507_inst_ack_0 : boolean;
  signal ptr_deref_495_store_0_ack_0 : boolean;
  signal ptr_deref_495_store_0_ack_1 : boolean;
  signal ptr_deref_495_gather_scatter_req_0 : boolean;
  signal ptr_deref_495_gather_scatter_ack_0 : boolean;
  signal binary_524_inst_req_0 : boolean;
  signal switch_stmt_579_select_expr_0_req_0 : boolean;
  signal switch_stmt_579_select_expr_0_ack_0 : boolean;
  signal switch_stmt_579_select_expr_0_req_1 : boolean;
  signal switch_stmt_579_select_expr_0_ack_1 : boolean;
  signal switch_stmt_579_branch_0_req_0 : boolean;
  signal type_cast_577_inst_req_0 : boolean;
  signal type_cast_577_inst_ack_0 : boolean;
  signal switch_stmt_579_branch_default_req_0 : boolean;
  signal binary_524_inst_req_1 : boolean;
  signal binary_524_inst_ack_1 : boolean;
  signal if_stmt_526_branch_ack_0 : boolean;
  signal binary_524_inst_ack_0 : boolean;
  signal simple_obj_ref_573_inst_req_0 : boolean;
  signal simple_obj_ref_573_inst_ack_0 : boolean;
  signal switch_stmt_579_select_expr_1_req_0 : boolean;
  signal switch_stmt_579_select_expr_1_ack_0 : boolean;
  signal switch_stmt_579_select_expr_1_req_1 : boolean;
  signal switch_stmt_579_select_expr_1_ack_1 : boolean;
  signal switch_stmt_579_branch_1_req_0 : boolean;
  signal switch_stmt_579_branch_0_ack_1 : boolean;
  signal switch_stmt_579_branch_1_ack_1 : boolean;
  signal switch_stmt_579_branch_default_ack_0 : boolean;
  signal ptr_deref_591_base_resize_req_0 : boolean;
  signal ptr_deref_591_base_resize_ack_0 : boolean;
  signal ptr_deref_591_root_address_inst_req_0 : boolean;
  signal ptr_deref_591_root_address_inst_ack_0 : boolean;
  signal ptr_deref_591_addr_0_req_0 : boolean;
  signal ptr_deref_591_addr_0_ack_0 : boolean;
  signal ptr_deref_591_gather_scatter_req_0 : boolean;
  signal ptr_deref_591_gather_scatter_ack_0 : boolean;
  signal ptr_deref_591_store_0_req_0 : boolean;
  signal ptr_deref_591_store_0_ack_0 : boolean;
  signal ptr_deref_591_store_0_req_1 : boolean;
  signal ptr_deref_591_store_0_ack_1 : boolean;
  signal array_obj_ref_598_index_0_resize_req_0 : boolean;
  signal array_obj_ref_598_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_598_index_0_rename_req_0 : boolean;
  signal array_obj_ref_598_index_0_rename_ack_0 : boolean;
  signal array_obj_ref_598_offset_inst_req_0 : boolean;
  signal array_obj_ref_598_offset_inst_ack_0 : boolean;
  signal array_obj_ref_598_base_resize_req_0 : boolean;
  signal array_obj_ref_598_base_resize_ack_0 : boolean;
  signal array_obj_ref_598_root_address_inst_req_0 : boolean;
  signal array_obj_ref_598_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_598_root_address_inst_req_1 : boolean;
  signal array_obj_ref_598_root_address_inst_ack_1 : boolean;
  signal array_obj_ref_598_final_reg_req_0 : boolean;
  signal array_obj_ref_598_final_reg_ack_0 : boolean;
  signal ptr_deref_601_base_resize_req_0 : boolean;
  signal ptr_deref_601_base_resize_ack_0 : boolean;
  signal ptr_deref_601_root_address_inst_req_0 : boolean;
  signal ptr_deref_601_root_address_inst_ack_0 : boolean;
  signal ptr_deref_601_addr_0_req_0 : boolean;
  signal ptr_deref_601_addr_0_ack_0 : boolean;
  signal ptr_deref_601_gather_scatter_req_0 : boolean;
  signal ptr_deref_601_gather_scatter_ack_0 : boolean;
  signal ptr_deref_601_store_0_req_0 : boolean;
  signal ptr_deref_601_store_0_ack_0 : boolean;
  signal ptr_deref_601_store_0_req_1 : boolean;
  signal ptr_deref_601_store_0_ack_1 : boolean;
  signal binary_610_inst_req_0 : boolean;
  signal binary_610_inst_ack_0 : boolean;
  signal binary_610_inst_req_1 : boolean;
  signal binary_610_inst_ack_1 : boolean;
  signal array_obj_ref_616_index_0_resize_req_0 : boolean;
  signal array_obj_ref_616_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_616_index_0_rename_req_0 : boolean;
  signal array_obj_ref_616_index_0_rename_ack_0 : boolean;
  signal array_obj_ref_616_offset_inst_req_0 : boolean;
  signal array_obj_ref_616_offset_inst_ack_0 : boolean;
  signal array_obj_ref_616_base_resize_req_0 : boolean;
  signal array_obj_ref_616_base_resize_ack_0 : boolean;
  signal array_obj_ref_616_root_address_inst_req_0 : boolean;
  signal array_obj_ref_616_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_616_root_address_inst_req_1 : boolean;
  signal array_obj_ref_616_root_address_inst_ack_1 : boolean;
  signal array_obj_ref_616_final_reg_req_0 : boolean;
  signal array_obj_ref_616_final_reg_ack_0 : boolean;
  signal ptr_deref_619_base_resize_req_0 : boolean;
  signal ptr_deref_619_base_resize_ack_0 : boolean;
  signal ptr_deref_619_root_address_inst_req_0 : boolean;
  signal ptr_deref_619_root_address_inst_ack_0 : boolean;
  signal ptr_deref_619_addr_0_req_0 : boolean;
  signal ptr_deref_619_addr_0_ack_0 : boolean;
  signal ptr_deref_619_gather_scatter_req_0 : boolean;
  signal ptr_deref_619_gather_scatter_ack_0 : boolean;
  signal ptr_deref_619_store_0_req_0 : boolean;
  signal ptr_deref_619_store_0_ack_0 : boolean;
  signal ptr_deref_619_store_0_req_1 : boolean;
  signal ptr_deref_619_store_0_ack_1 : boolean;
  signal binary_626_inst_req_0 : boolean;
  signal binary_626_inst_ack_0 : boolean;
  signal binary_626_inst_req_1 : boolean;
  signal binary_626_inst_ack_1 : boolean;
  signal simple_obj_ref_634_inst_req_0 : boolean;
  signal simple_obj_ref_634_inst_ack_0 : boolean;
  signal simple_obj_ref_643_inst_req_0 : boolean;
  signal simple_obj_ref_643_inst_ack_0 : boolean;
  signal simple_obj_ref_652_inst_req_0 : boolean;
  signal simple_obj_ref_652_inst_ack_0 : boolean;
  signal phi_stmt_549_req_0 : boolean;
  signal type_cast_555_inst_req_0 : boolean;
  signal type_cast_555_inst_ack_0 : boolean;
  signal phi_stmt_549_req_1 : boolean;
  signal phi_stmt_549_ack_0 : boolean;
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
  wrapper_input_CP_1437: Block -- control-path 
    signal cp_elements: BooleanArray(94 downto 0);
    -- 
  begin -- 
    cp_elements(0) <= start_req_symbol;
    start_ack_symbol <= cp_elements(1);
    finAckJoin: join2 port map(pred0 => fin_req_symbol, pred1 => cp_elements(1), symbol_out => fin_ack_symbol, clk => clk, reset => reset);
    ptr_deref_495_gather_scatter_req_0 <= cp_elements(0);
    cp_elements(1) <= false; 
    cp_elements(2) <= OrReduce(cp_elements(17) & cp_elements(86));
    simple_obj_ref_540_inst_req_0 <= cp_elements(2);
    cp_elements(3) <= OrReduce(cp_elements(39) & cp_elements(92));
    ptr_deref_591_base_resize_req_0 <= cp_elements(3);
    cp_elements(4) <= ptr_deref_495_gather_scatter_ack_0;
    ptr_deref_495_store_0_req_0 <= cp_elements(4);
    cp_elements(5) <= ptr_deref_495_store_0_ack_0;
    ptr_deref_495_store_0_req_1 <= cp_elements(5);
    cp_elements(6) <= ptr_deref_495_store_0_ack_1;
    cp_elements(7) <= simple_obj_ref_507_inst_ack_0;
    simple_obj_ref_518_inst_req_0 <= cp_elements(7);
    cp_elements(8) <= simple_obj_ref_518_inst_ack_0;
    binary_524_inst_req_0 <= cp_elements(8);
    cp_elements(9) <= binary_524_inst_ack_0;
    binary_524_inst_req_1 <= cp_elements(9);
    cp_elements(10) <= binary_524_inst_ack_1;
    cp_elements(11) <= cp_elements(10);
    cp_elements(12) <= false;
    cp_elements(13) <= cp_elements(12);
    cp_elements(14) <= cp_elements(10);
    if_stmt_526_branch_req_0 <= cp_elements(14);
    cp_elements(15) <= cp_elements(14);
    cp_elements(16) <= cp_elements(15);
    cp_elements(17) <= if_stmt_526_branch_ack_1;
    cp_elements(18) <= cp_elements(15);
    cp_elements(19) <= if_stmt_526_branch_ack_0;
    cp_elements(20) <= simple_obj_ref_540_inst_ack_0;
    type_cast_545_inst_req_0 <= cp_elements(20);
    cp_elements(21) <= type_cast_545_inst_ack_0;
    phi_stmt_549_req_0 <= cp_elements(21);
    cp_elements(22) <= simple_obj_ref_564_inst_ack_0;
    simple_obj_ref_573_inst_req_0 <= cp_elements(22);
    cp_elements(23) <= simple_obj_ref_573_inst_ack_0;
    type_cast_577_inst_req_0 <= cp_elements(23);
    cp_elements(24) <= type_cast_577_inst_ack_0;
    cp_elements(25) <= cp_elements(24);
    cp_elements(26) <= false;
    cp_elements(27) <= cp_elements(26);
    cp_elements(28) <= cp_elements(24);
    cp_elements(29) <= cp_elements(28);
    cp_elements(30) <= cp_elements(29);
    switch_stmt_579_select_expr_0_req_0 <= cp_elements(30);
    cp_elements(31) <= switch_stmt_579_select_expr_0_ack_0;
    switch_stmt_579_select_expr_0_req_1 <= cp_elements(31);
    cp_elements(32) <= switch_stmt_579_select_expr_0_ack_1;
    switch_stmt_579_branch_0_req_0 <= cp_elements(32);
    cp_elements(33) <= cp_elements(29);
    switch_stmt_579_select_expr_1_req_0 <= cp_elements(33);
    cp_elements(34) <= switch_stmt_579_select_expr_1_ack_0;
    switch_stmt_579_select_expr_1_req_1 <= cp_elements(34);
    cp_elements(35) <= switch_stmt_579_select_expr_1_ack_1;
    switch_stmt_579_branch_1_req_0 <= cp_elements(35);
    cpelement_group_36 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(32) & cp_elements(35));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(36),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    switch_stmt_579_branch_default_req_0 <= cp_elements(36);
    cp_elements(37) <= cp_elements(36);
    cp_elements(38) <= cp_elements(37);
    cp_elements(39) <= switch_stmt_579_branch_0_ack_1;
    cp_elements(40) <= cp_elements(37);
    cp_elements(41) <= switch_stmt_579_branch_1_ack_1;
    array_obj_ref_598_index_0_resize_req_0 <= cp_elements(41);
    cp_elements(42) <= cp_elements(37);
    cp_elements(43) <= switch_stmt_579_branch_default_ack_0;
    array_obj_ref_616_index_0_resize_req_0 <= cp_elements(43);
    cp_elements(44) <= ptr_deref_591_base_resize_ack_0;
    ptr_deref_591_root_address_inst_req_0 <= cp_elements(44);
    cp_elements(45) <= ptr_deref_591_root_address_inst_ack_0;
    ptr_deref_591_addr_0_req_0 <= cp_elements(45);
    cp_elements(46) <= ptr_deref_591_addr_0_ack_0;
    ptr_deref_591_gather_scatter_req_0 <= cp_elements(46);
    cp_elements(47) <= ptr_deref_591_gather_scatter_ack_0;
    ptr_deref_591_store_0_req_0 <= cp_elements(47);
    cp_elements(48) <= ptr_deref_591_store_0_ack_0;
    ptr_deref_591_store_0_req_1 <= cp_elements(48);
    cp_elements(49) <= ptr_deref_591_store_0_ack_1;
    cp_elements(50) <= array_obj_ref_598_index_0_resize_ack_0;
    array_obj_ref_598_index_0_rename_req_0 <= cp_elements(50);
    cp_elements(51) <= array_obj_ref_598_index_0_rename_ack_0;
    array_obj_ref_598_offset_inst_req_0 <= cp_elements(51);
    cp_elements(52) <= array_obj_ref_598_offset_inst_ack_0;
    array_obj_ref_598_base_resize_req_0 <= cp_elements(52);
    cp_elements(53) <= array_obj_ref_598_base_resize_ack_0;
    array_obj_ref_598_root_address_inst_req_0 <= cp_elements(53);
    cp_elements(54) <= array_obj_ref_598_root_address_inst_ack_0;
    array_obj_ref_598_root_address_inst_req_1 <= cp_elements(54);
    cp_elements(55) <= array_obj_ref_598_root_address_inst_ack_1;
    array_obj_ref_598_final_reg_req_0 <= cp_elements(55);
    cp_elements(56) <= array_obj_ref_598_final_reg_ack_0;
    ptr_deref_601_base_resize_req_0 <= cp_elements(56);
    cp_elements(57) <= ptr_deref_601_base_resize_ack_0;
    ptr_deref_601_root_address_inst_req_0 <= cp_elements(57);
    cp_elements(58) <= ptr_deref_601_root_address_inst_ack_0;
    ptr_deref_601_addr_0_req_0 <= cp_elements(58);
    cp_elements(59) <= ptr_deref_601_addr_0_ack_0;
    ptr_deref_601_gather_scatter_req_0 <= cp_elements(59);
    cp_elements(60) <= ptr_deref_601_gather_scatter_ack_0;
    ptr_deref_601_store_0_req_0 <= cp_elements(60);
    cp_elements(61) <= ptr_deref_601_store_0_ack_0;
    ptr_deref_601_store_0_req_1 <= cp_elements(61);
    cp_elements(62) <= ptr_deref_601_store_0_ack_1;
    cp_elements(63) <= binary_610_inst_ack_0;
    binary_610_inst_req_1 <= cp_elements(63);
    cp_elements(64) <= binary_610_inst_ack_1;
    type_cast_555_inst_req_0 <= cp_elements(64);
    cp_elements(65) <= array_obj_ref_616_index_0_resize_ack_0;
    array_obj_ref_616_index_0_rename_req_0 <= cp_elements(65);
    cp_elements(66) <= array_obj_ref_616_index_0_rename_ack_0;
    array_obj_ref_616_offset_inst_req_0 <= cp_elements(66);
    cp_elements(67) <= array_obj_ref_616_offset_inst_ack_0;
    array_obj_ref_616_base_resize_req_0 <= cp_elements(67);
    cp_elements(68) <= array_obj_ref_616_base_resize_ack_0;
    array_obj_ref_616_root_address_inst_req_0 <= cp_elements(68);
    cp_elements(69) <= array_obj_ref_616_root_address_inst_ack_0;
    array_obj_ref_616_root_address_inst_req_1 <= cp_elements(69);
    cp_elements(70) <= array_obj_ref_616_root_address_inst_ack_1;
    array_obj_ref_616_final_reg_req_0 <= cp_elements(70);
    cp_elements(71) <= array_obj_ref_616_final_reg_ack_0;
    ptr_deref_619_base_resize_req_0 <= cp_elements(71);
    cp_elements(72) <= ptr_deref_619_base_resize_ack_0;
    ptr_deref_619_root_address_inst_req_0 <= cp_elements(72);
    cp_elements(73) <= ptr_deref_619_root_address_inst_ack_0;
    ptr_deref_619_addr_0_req_0 <= cp_elements(73);
    cp_elements(74) <= ptr_deref_619_addr_0_ack_0;
    ptr_deref_619_gather_scatter_req_0 <= cp_elements(74);
    cp_elements(75) <= ptr_deref_619_gather_scatter_ack_0;
    ptr_deref_619_store_0_req_0 <= cp_elements(75);
    cp_elements(76) <= ptr_deref_619_store_0_ack_0;
    ptr_deref_619_store_0_req_1 <= cp_elements(76);
    cp_elements(77) <= ptr_deref_619_store_0_ack_1;
    binary_626_inst_req_0 <= cp_elements(77);
    cp_elements(78) <= binary_626_inst_ack_0;
    binary_626_inst_req_1 <= cp_elements(78);
    cp_elements(79) <= binary_626_inst_ack_1;
    simple_obj_ref_634_inst_req_0 <= cp_elements(79);
    cp_elements(80) <= simple_obj_ref_634_inst_ack_0;
    simple_obj_ref_643_inst_req_0 <= cp_elements(80);
    cp_elements(81) <= simple_obj_ref_643_inst_ack_0;
    simple_obj_ref_652_inst_req_0 <= cp_elements(81);
    cp_elements(82) <= simple_obj_ref_652_inst_ack_0;
    cp_elements(83) <= OrReduce(cp_elements(6) & cp_elements(19) & cp_elements(82));
    cp_elements(84) <= cp_elements(83);
    simple_obj_ref_507_inst_req_0 <= cp_elements(84);
    cp_elements(85) <= false;
    cp_elements(86) <= cp_elements(85);
    cp_elements(87) <= type_cast_555_inst_ack_0;
    phi_stmt_549_req_1 <= cp_elements(87);
    cp_elements(88) <= OrReduce(cp_elements(21) & cp_elements(87));
    cp_elements(89) <= cp_elements(88);
    cp_elements(90) <= phi_stmt_549_ack_0;
    simple_obj_ref_564_inst_req_0 <= cp_elements(90);
    cp_elements(91) <= false;
    cp_elements(92) <= cp_elements(91);
    cp_elements(93) <= OrReduce(cp_elements(49) & cp_elements(62));
    cp_elements(94) <= cp_elements(93);
    binary_610_inst_req_0 <= cp_elements(94);
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal array_obj_ref_598_final_offset : std_logic_vector(10 downto 0);
    signal array_obj_ref_598_offset_scale_factor_0 : std_logic_vector(10 downto 0);
    signal array_obj_ref_598_resized_base_address : std_logic_vector(10 downto 0);
    signal array_obj_ref_598_root_address : std_logic_vector(10 downto 0);
    signal array_obj_ref_616_final_offset : std_logic_vector(10 downto 0);
    signal array_obj_ref_616_offset_scale_factor_0 : std_logic_vector(10 downto 0);
    signal array_obj_ref_616_resized_base_address : std_logic_vector(10 downto 0);
    signal array_obj_ref_616_root_address : std_logic_vector(10 downto 0);
    signal expr_581_wire_constant : std_logic_vector(31 downto 0);
    signal expr_581_wire_constant_cmp : std_logic_vector(0 downto 0);
    signal expr_584_wire_constant : std_logic_vector(31 downto 0);
    signal expr_584_wire_constant_cmp : std_logic_vector(0 downto 0);
    signal iNsTr_0_493 : std_logic_vector(31 downto 0);
    signal iNsTr_10_562 : std_logic_vector(31 downto 0);
    signal iNsTr_11_571 : std_logic_vector(31 downto 0);
    signal iNsTr_14_633 : std_logic_vector(31 downto 0);
    signal iNsTr_16_642 : std_logic_vector(31 downto 0);
    signal iNsTr_18_651 : std_logic_vector(31 downto 0);
    signal iNsTr_3_506 : std_logic_vector(31 downto 0);
    signal iNsTr_5_516 : std_logic_vector(31 downto 0);
    signal iNsTr_7_538 : std_logic_vector(31 downto 0);
    signal iNsTr_9_549 : std_logic_vector(31 downto 0);
    signal ptr_deref_495_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_495_wire : std_logic_vector(7 downto 0);
    signal ptr_deref_495_word_address_0 : std_logic_vector(3 downto 0);
    signal ptr_deref_591_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_591_resized_base_address : std_logic_vector(10 downto 0);
    signal ptr_deref_591_root_address : std_logic_vector(10 downto 0);
    signal ptr_deref_591_wire : std_logic_vector(63 downto 0);
    signal ptr_deref_591_word_address_0 : std_logic_vector(10 downto 0);
    signal ptr_deref_591_word_offset_0 : std_logic_vector(10 downto 0);
    signal ptr_deref_601_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_601_resized_base_address : std_logic_vector(10 downto 0);
    signal ptr_deref_601_root_address : std_logic_vector(10 downto 0);
    signal ptr_deref_601_wire : std_logic_vector(63 downto 0);
    signal ptr_deref_601_word_address_0 : std_logic_vector(10 downto 0);
    signal ptr_deref_601_word_offset_0 : std_logic_vector(10 downto 0);
    signal ptr_deref_619_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_619_resized_base_address : std_logic_vector(10 downto 0);
    signal ptr_deref_619_root_address : std_logic_vector(10 downto 0);
    signal ptr_deref_619_wire : std_logic_vector(63 downto 0);
    signal ptr_deref_619_word_address_0 : std_logic_vector(10 downto 0);
    signal ptr_deref_619_word_offset_0 : std_logic_vector(10 downto 0);
    signal simple_obj_ref_597_resized : std_logic_vector(10 downto 0);
    signal simple_obj_ref_597_scaled : std_logic_vector(10 downto 0);
    signal simple_obj_ref_615_resized : std_logic_vector(10 downto 0);
    signal simple_obj_ref_615_scaled : std_logic_vector(10 downto 0);
    signal tmp12_599 : std_logic_vector(31 downto 0);
    signal tmp15_617 : std_logic_vector(31 downto 0);
    signal tmp16_627 : std_logic_vector(31 downto 0);
    signal tmp2x_xi_525 : std_logic_vector(0 downto 0);
    signal tmp4_546 : std_logic_vector(31 downto 0);
    signal tmp4x_xi_541 : std_logic_vector(31 downto 0);
    signal tmp6_565 : std_logic_vector(63 downto 0);
    signal tmp7_574 : std_logic_vector(7 downto 0);
    signal tmp8_578 : std_logic_vector(31 downto 0);
    signal tmpx_xi_519 : std_logic_vector(7 downto 0);
    signal type_cast_497_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_509_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_523_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_553_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_555_wire : std_logic_vector(31 downto 0);
    signal type_cast_609_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_625_wire_constant : std_logic_vector(31 downto 0);
    signal wordx_x0x_xbe_611 : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    array_obj_ref_598_offset_scale_factor_0 <= "00000000001";
    array_obj_ref_616_offset_scale_factor_0 <= "00000000001";
    expr_581_wire_constant <= "00000000000000000000000011111111";
    expr_584_wire_constant <= "00000000000000000000000000000000";
    iNsTr_0_493 <= "00000000000000000000000000000000";
    iNsTr_10_562 <= "00000000000000000000000000000000";
    iNsTr_11_571 <= "00000000000000000000000000000000";
    iNsTr_14_633 <= "00000000000000000000000000000000";
    iNsTr_16_642 <= "00000000000000000000000000000000";
    iNsTr_18_651 <= "00000000000000000000000000000000";
    iNsTr_3_506 <= "00000000000000000000000000000000";
    iNsTr_5_516 <= "00000000000000000000000000000000";
    iNsTr_7_538 <= "00000000000000000000000000000000";
    ptr_deref_495_word_address_0 <= "0000";
    ptr_deref_591_word_offset_0 <= "00000000000";
    ptr_deref_601_word_offset_0 <= "00000000000";
    ptr_deref_619_word_offset_0 <= "00000000000";
    type_cast_497_wire_constant <= "00000001";
    type_cast_509_wire_constant <= "00000010";
    type_cast_523_wire_constant <= "00000011";
    type_cast_553_wire_constant <= "00000000000000000000000000000000";
    type_cast_609_wire_constant <= "00000000000000000000000000000001";
    type_cast_625_wire_constant <= "00000000000000000000000000000001";
    phi_stmt_549: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_553_wire_constant & type_cast_555_wire;
      req <= phi_stmt_549_req_0 & phi_stmt_549_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_549_ack_0,
          idata => idata,
          odata => iNsTr_9_549,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_549
    array_obj_ref_598_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 11, flow_through => true ) 
      port map( din => tmp4_546, dout => array_obj_ref_598_resized_base_address, req => array_obj_ref_598_base_resize_req_0, ack => array_obj_ref_598_base_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_598_final_reg: RegisterBase --
      generic map(in_data_width => 11,out_data_width => 32, flow_through => false ) 
      port map( din => array_obj_ref_598_root_address, dout => tmp12_599, req => array_obj_ref_598_final_reg_req_0, ack => array_obj_ref_598_final_reg_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_598_index_0_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 11, flow_through => true ) 
      port map( din => iNsTr_9_549, dout => simple_obj_ref_597_resized, req => array_obj_ref_598_index_0_resize_req_0, ack => array_obj_ref_598_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_598_offset_inst: RegisterBase --
      generic map(in_data_width => 11,out_data_width => 11, flow_through => true ) 
      port map( din => simple_obj_ref_597_scaled, dout => array_obj_ref_598_final_offset, req => array_obj_ref_598_offset_inst_req_0, ack => array_obj_ref_598_offset_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_616_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 11, flow_through => true ) 
      port map( din => tmp4_546, dout => array_obj_ref_616_resized_base_address, req => array_obj_ref_616_base_resize_req_0, ack => array_obj_ref_616_base_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_616_final_reg: RegisterBase --
      generic map(in_data_width => 11,out_data_width => 32, flow_through => false ) 
      port map( din => array_obj_ref_616_root_address, dout => tmp15_617, req => array_obj_ref_616_final_reg_req_0, ack => array_obj_ref_616_final_reg_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_616_index_0_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 11, flow_through => true ) 
      port map( din => iNsTr_9_549, dout => simple_obj_ref_615_resized, req => array_obj_ref_616_index_0_resize_req_0, ack => array_obj_ref_616_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_616_offset_inst: RegisterBase --
      generic map(in_data_width => 11,out_data_width => 11, flow_through => true ) 
      port map( din => simple_obj_ref_615_scaled, dout => array_obj_ref_616_final_offset, req => array_obj_ref_616_offset_inst_req_0, ack => array_obj_ref_616_offset_inst_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_591_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 11, flow_through => true ) 
      port map( din => tmp4_546, dout => ptr_deref_591_resized_base_address, req => ptr_deref_591_base_resize_req_0, ack => ptr_deref_591_base_resize_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_601_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 11, flow_through => true ) 
      port map( din => tmp12_599, dout => ptr_deref_601_resized_base_address, req => ptr_deref_601_base_resize_req_0, ack => ptr_deref_601_base_resize_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_619_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 11, flow_through => true ) 
      port map( din => tmp15_617, dout => ptr_deref_619_resized_base_address, req => ptr_deref_619_base_resize_req_0, ack => ptr_deref_619_base_resize_ack_0, clk => clk, reset => reset); -- 
    type_cast_545_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => false ) 
      port map( din => tmp4x_xi_541, dout => tmp4_546, req => type_cast_545_inst_req_0, ack => type_cast_545_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_555_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => wordx_x0x_xbe_611, dout => type_cast_555_wire, req => type_cast_555_inst_req_0, ack => type_cast_555_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_577_inst: RegisterBase --
      generic map(in_data_width => 8,out_data_width => 32, flow_through => false ) 
      port map( din => tmp7_574, dout => tmp8_578, req => type_cast_577_inst_req_0, ack => type_cast_577_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_598_index_0_rename: Block -- 
      signal aggregated_sig: std_logic_vector(10 downto 0); --
    begin -- 
      array_obj_ref_598_index_0_rename_ack_0 <= array_obj_ref_598_index_0_rename_req_0;
      aggregated_sig <= simple_obj_ref_597_resized;
      simple_obj_ref_597_scaled <= aggregated_sig(10 downto 0);
      --
    end Block;
    array_obj_ref_616_index_0_rename: Block -- 
      signal aggregated_sig: std_logic_vector(10 downto 0); --
    begin -- 
      array_obj_ref_616_index_0_rename_ack_0 <= array_obj_ref_616_index_0_rename_req_0;
      aggregated_sig <= simple_obj_ref_615_resized;
      simple_obj_ref_615_scaled <= aggregated_sig(10 downto 0);
      --
    end Block;
    ptr_deref_495_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_495_gather_scatter_ack_0 <= ptr_deref_495_gather_scatter_req_0;
      aggregated_sig <= type_cast_497_wire_constant;
      ptr_deref_495_data_0 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_591_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(10 downto 0); --
    begin -- 
      ptr_deref_591_addr_0_ack_0 <= ptr_deref_591_addr_0_req_0;
      aggregated_sig <= ptr_deref_591_root_address;
      ptr_deref_591_word_address_0 <= aggregated_sig(10 downto 0);
      --
    end Block;
    ptr_deref_591_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_591_gather_scatter_ack_0 <= ptr_deref_591_gather_scatter_req_0;
      aggregated_sig <= tmp6_565;
      ptr_deref_591_data_0 <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_591_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(10 downto 0); --
    begin -- 
      ptr_deref_591_root_address_inst_ack_0 <= ptr_deref_591_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_591_resized_base_address;
      ptr_deref_591_root_address <= aggregated_sig(10 downto 0);
      --
    end Block;
    ptr_deref_601_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(10 downto 0); --
    begin -- 
      ptr_deref_601_addr_0_ack_0 <= ptr_deref_601_addr_0_req_0;
      aggregated_sig <= ptr_deref_601_root_address;
      ptr_deref_601_word_address_0 <= aggregated_sig(10 downto 0);
      --
    end Block;
    ptr_deref_601_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_601_gather_scatter_ack_0 <= ptr_deref_601_gather_scatter_req_0;
      aggregated_sig <= tmp6_565;
      ptr_deref_601_data_0 <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_601_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(10 downto 0); --
    begin -- 
      ptr_deref_601_root_address_inst_ack_0 <= ptr_deref_601_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_601_resized_base_address;
      ptr_deref_601_root_address <= aggregated_sig(10 downto 0);
      --
    end Block;
    ptr_deref_619_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(10 downto 0); --
    begin -- 
      ptr_deref_619_addr_0_ack_0 <= ptr_deref_619_addr_0_req_0;
      aggregated_sig <= ptr_deref_619_root_address;
      ptr_deref_619_word_address_0 <= aggregated_sig(10 downto 0);
      --
    end Block;
    ptr_deref_619_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_619_gather_scatter_ack_0 <= ptr_deref_619_gather_scatter_req_0;
      aggregated_sig <= tmp6_565;
      ptr_deref_619_data_0 <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_619_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(10 downto 0); --
    begin -- 
      ptr_deref_619_root_address_inst_ack_0 <= ptr_deref_619_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_619_resized_base_address;
      ptr_deref_619_root_address <= aggregated_sig(10 downto 0);
      --
    end Block;
    if_stmt_526_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= tmp2x_xi_525;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_526_branch_req_0,
          ack0 => if_stmt_526_branch_ack_0,
          ack1 => if_stmt_526_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_579_branch_0: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= expr_581_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_579_branch_0_req_0,
          ack0 => open,
          ack1 => switch_stmt_579_branch_0_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_579_branch_1: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= expr_584_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_579_branch_1_req_0,
          ack0 => open,
          ack1 => switch_stmt_579_branch_1_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_579_branch_default: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(1 downto 0);
      begin 
      condition_sig <= expr_581_wire_constant_cmp & expr_584_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 2)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_579_branch_default_req_0,
          ack0 => switch_stmt_579_branch_default_ack_0,
          ack1 => open,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : array_obj_ref_598_root_address_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(21 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= array_obj_ref_598_final_offset & array_obj_ref_598_resized_base_address;
      array_obj_ref_598_root_address <= data_out(10 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 11,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 11, 
          num_inputs    => 2,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 11,
          constant_operand => "0",
          constant_width => 1,
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => array_obj_ref_598_root_address_inst_req_0,
          ackL => array_obj_ref_598_root_address_inst_ack_0,
          reqR => array_obj_ref_598_root_address_inst_req_1,
          ackR => array_obj_ref_598_root_address_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : array_obj_ref_616_root_address_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(21 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= array_obj_ref_616_final_offset & array_obj_ref_616_resized_base_address;
      array_obj_ref_616_root_address <= data_out(10 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 11,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 11, 
          num_inputs    => 2,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 11,
          constant_operand => "0",
          constant_width => 1,
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => array_obj_ref_616_root_address_inst_req_0,
          ackL => array_obj_ref_616_root_address_inst_ack_0,
          reqR => array_obj_ref_616_root_address_inst_req_1,
          ackR => array_obj_ref_616_root_address_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : binary_524_inst 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmpx_xi_519;
      tmp2x_xi_525 <= data_out(0 downto 0);
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
          constant_operand => "00000011",
          constant_width => 8,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_524_inst_req_0,
          ackL => binary_524_inst_ack_0,
          reqR => binary_524_inst_req_1,
          ackR => binary_524_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : binary_610_inst 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_9_549;
      wordx_x0x_xbe_611 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_610_inst_req_0,
          ackL => binary_610_inst_ack_0,
          reqR => binary_610_inst_req_1,
          ackR => binary_610_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : binary_626_inst 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_9_549;
      tmp16_627 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_626_inst_req_0,
          ackL => binary_626_inst_ack_0,
          reqR => binary_626_inst_req_1,
          ackR => binary_626_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared split operator group (5) : switch_stmt_579_select_expr_0 
    SplitOperatorGroup5: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp8_578;
      expr_581_wire_constant_cmp <= data_out(0 downto 0);
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
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => switch_stmt_579_select_expr_0_req_0,
          ackL => switch_stmt_579_select_expr_0_ack_0,
          reqR => switch_stmt_579_select_expr_0_req_1,
          ackR => switch_stmt_579_select_expr_0_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 5
    -- shared split operator group (6) : switch_stmt_579_select_expr_1 
    SplitOperatorGroup6: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp8_578;
      expr_584_wire_constant_cmp <= data_out(0 downto 0);
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
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => switch_stmt_579_select_expr_1_req_0,
          ackL => switch_stmt_579_select_expr_1_ack_0,
          reqR => switch_stmt_579_select_expr_1_req_1,
          ackR => switch_stmt_579_select_expr_1_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 6
    -- logging on!
    process(clk)  begin -- 
      if clk'event and clk = '1' then -- 
        if ptr_deref_495_store_0_ack_1 then -- 
          assert false report " WriteMem  memory_space_1 address ptr_deref_495_word_address_0 ="  &  convert_slv_to_hex_string(ptr_deref_495_word_address_0) &  " data ptr_deref_495_data_0 ="  &  convert_slv_to_hex_string(ptr_deref_495_data_0) severity note; --
        end if;
        --
      end if;
      -- 
    end process;
    -- shared store operator group (0) : ptr_deref_495_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(3 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_495_store_0_req_0;
      ptr_deref_495_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_495_store_0_req_1;
      ptr_deref_495_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_495_word_address_0;
      data_in <= ptr_deref_495_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 4,
        data_width => 8,
        num_reqs => 1,
        tag_length => 1,
        min_clock_period => false,
        no_arbitration => false)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_1_sr_req(0),
          mack => memory_space_1_sr_ack(0),
          maddr => memory_space_1_sr_addr(3 downto 0),
          mdata => memory_space_1_sr_data(7 downto 0),
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
    end Block; -- store group 0
    -- logging on!
    process(clk)  begin -- 
      if clk'event and clk = '1' then -- 
        if ptr_deref_591_store_0_ack_1 then -- 
          assert false report " WriteMem  memory_space_3 address ptr_deref_591_word_address_0 ="  &  convert_slv_to_hex_string(ptr_deref_591_word_address_0) &  " data ptr_deref_591_data_0 ="  &  convert_slv_to_hex_string(ptr_deref_591_data_0) severity note; --
        end if;
        if ptr_deref_601_store_0_ack_1 then -- 
          assert false report " WriteMem  memory_space_3 address ptr_deref_601_word_address_0 ="  &  convert_slv_to_hex_string(ptr_deref_601_word_address_0) &  " data ptr_deref_601_data_0 ="  &  convert_slv_to_hex_string(ptr_deref_601_data_0) severity note; --
        end if;
        if ptr_deref_619_store_0_ack_1 then -- 
          assert false report " WriteMem  memory_space_3 address ptr_deref_619_word_address_0 ="  &  convert_slv_to_hex_string(ptr_deref_619_word_address_0) &  " data ptr_deref_619_data_0 ="  &  convert_slv_to_hex_string(ptr_deref_619_data_0) severity note; --
        end if;
        --
      end if;
      -- 
    end process;
    -- shared store operator group (1) : ptr_deref_591_store_0 ptr_deref_601_store_0 ptr_deref_619_store_0 
    StoreGroup1: Block -- 
      signal addr_in: std_logic_vector(32 downto 0);
      signal data_in: std_logic_vector(191 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 2 downto 0);
      -- 
    begin -- 
      reqL(2) <= ptr_deref_591_store_0_req_0;
      reqL(1) <= ptr_deref_601_store_0_req_0;
      reqL(0) <= ptr_deref_619_store_0_req_0;
      ptr_deref_591_store_0_ack_0 <= ackL(2);
      ptr_deref_601_store_0_ack_0 <= ackL(1);
      ptr_deref_619_store_0_ack_0 <= ackL(0);
      reqR(2) <= ptr_deref_591_store_0_req_1;
      reqR(1) <= ptr_deref_601_store_0_req_1;
      reqR(0) <= ptr_deref_619_store_0_req_1;
      ptr_deref_591_store_0_ack_1 <= ackR(2);
      ptr_deref_601_store_0_ack_1 <= ackR(1);
      ptr_deref_619_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_591_word_address_0 & ptr_deref_601_word_address_0 & ptr_deref_619_word_address_0;
      data_in <= ptr_deref_591_data_0 & ptr_deref_601_data_0 & ptr_deref_619_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 11,
        data_width => 64,
        num_reqs => 3,
        tag_length => 2,
        min_clock_period => false,
        no_arbitration => false)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_3_sr_req(0),
          mack => memory_space_3_sr_ack(0),
          maddr => memory_space_3_sr_addr(10 downto 0),
          mdata => memory_space_3_sr_data(63 downto 0),
          mtag => memory_space_3_sr_tag(1 downto 0),
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
          mreq => memory_space_3_sc_req(0),
          mack => memory_space_3_sc_ack(0),
          mtag => memory_space_3_sc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 1
    -- shared inport operator group (0) : simple_obj_ref_518_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      -- logging on!
      process(clk)  begin -- 
        if clk'event and clk = '1' then -- 
          if simple_obj_ref_518_inst_ack_0 then -- 
            assert false report " ReadPipe free_queue_ack to wire tmpx_xi_519 value="  &  convert_slv_to_hex_string(data_out(7 downto 0))  severity note; --
          end if;
          --
        end if;
        -- 
      end process;
      req(0) <= simple_obj_ref_518_inst_req_0;
      simple_obj_ref_518_inst_ack_0 <= ack(0);
      tmpx_xi_519 <= data_out(7 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 8,  num_reqs => 1,  no_arbitration => false)
        port map (-- 
          req => req , 
          ack => ack , 
          data => data_out, 
          oreq => free_queue_ack_pipe_read_req(0),
          oack => free_queue_ack_pipe_read_ack(0),
          odata => free_queue_ack_pipe_read_data(7 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared inport operator group (1) : simple_obj_ref_540_inst 
    InportGroup1: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      -- logging on!
      process(clk)  begin -- 
        if clk'event and clk = '1' then -- 
          if simple_obj_ref_540_inst_ack_0 then -- 
            assert false report " ReadPipe free_queue_get to wire tmp4x_xi_541 value="  &  convert_slv_to_hex_string(data_out(31 downto 0))  severity note; --
          end if;
          --
        end if;
        -- 
      end process;
      req(0) <= simple_obj_ref_540_inst_req_0;
      simple_obj_ref_540_inst_ack_0 <= ack(0);
      tmp4x_xi_541 <= data_out(31 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => false)
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
    end Block; -- inport group 1
    -- shared inport operator group (2) : simple_obj_ref_564_inst 
    InportGroup2: Block -- 
      signal data_out: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      -- logging on!
      process(clk)  begin -- 
        if clk'event and clk = '1' then -- 
          if simple_obj_ref_564_inst_ack_0 then -- 
            assert false report " ReadPipe in_data to wire tmp6_565 value="  &  convert_slv_to_hex_string(data_out(63 downto 0))  severity note; --
          end if;
          --
        end if;
        -- 
      end process;
      req(0) <= simple_obj_ref_564_inst_req_0;
      simple_obj_ref_564_inst_ack_0 <= ack(0);
      tmp6_565 <= data_out(63 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 64,  num_reqs => 1,  no_arbitration => false)
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
    end Block; -- inport group 2
    -- shared inport operator group (3) : simple_obj_ref_573_inst 
    InportGroup3: Block -- 
      signal data_out: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      -- logging on!
      process(clk)  begin -- 
        if clk'event and clk = '1' then -- 
          if simple_obj_ref_573_inst_ack_0 then -- 
            assert false report " ReadPipe in_ctrl to wire tmp7_574 value="  &  convert_slv_to_hex_string(data_out(7 downto 0))  severity note; --
          end if;
          --
        end if;
        -- 
      end process;
      req(0) <= simple_obj_ref_573_inst_req_0;
      simple_obj_ref_573_inst_ack_0 <= ack(0);
      tmp7_574 <= data_out(7 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 8,  num_reqs => 1,  no_arbitration => false)
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
    end Block; -- inport group 3
    -- logging on!
    process(clk)  begin -- 
      if clk'event and clk = '1' then -- 
        if simple_obj_ref_507_inst_ack_0 then -- 
          assert false report " WritePipe free_queue_request from wire type_cast_509_wire_constant value="  &  convert_slv_to_hex_string(type_cast_509_wire_constant) severity note; --
        end if;
        --
      end if;
      -- 
    end process;
    -- shared outport operator group (0) : simple_obj_ref_507_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_507_inst_req_0;
      simple_obj_ref_507_inst_ack_0 <= ack(0);
      data_in <= type_cast_509_wire_constant;
      outport: OutputPort -- 
        generic map ( data_width => 8,  num_reqs => 1,  no_arbitration => false)
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
    -- logging on!
    process(clk)  begin -- 
      if clk'event and clk = '1' then -- 
        if simple_obj_ref_634_inst_ack_0 then -- 
          assert false report " WritePipe midpipe from wire tmp4x_xi_541 value="  &  convert_slv_to_hex_string(tmp4x_xi_541) severity note; --
        end if;
        --
      end if;
      -- 
    end process;
    -- shared outport operator group (1) : simple_obj_ref_634_inst 
    OutportGroup1: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_634_inst_req_0;
      simple_obj_ref_634_inst_ack_0 <= ack(0);
      data_in <= tmp4x_xi_541;
      outport: OutputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => false)
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
    end Block; -- outport group 1
    -- logging on!
    process(clk)  begin -- 
      if clk'event and clk = '1' then -- 
        if simple_obj_ref_643_inst_ack_0 then -- 
          assert false report " WritePipe last_ctrl from wire tmp7_574 value="  &  convert_slv_to_hex_string(tmp7_574) severity note; --
        end if;
        --
      end if;
      -- 
    end process;
    -- shared outport operator group (2) : simple_obj_ref_643_inst 
    OutportGroup2: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_643_inst_req_0;
      simple_obj_ref_643_inst_ack_0 <= ack(0);
      data_in <= tmp7_574;
      outport: OutputPort -- 
        generic map ( data_width => 8,  num_reqs => 1,  no_arbitration => false)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => last_ctrl_pipe_write_req(0),
          oack => last_ctrl_pipe_write_ack(0),
          odata => last_ctrl_pipe_write_data(7 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 2
    -- logging on!
    process(clk)  begin -- 
      if clk'event and clk = '1' then -- 
        if simple_obj_ref_652_inst_ack_0 then -- 
          assert false report " WritePipe pkt_length from wire tmp16_627 value="  &  convert_slv_to_hex_string(tmp16_627) severity note; --
        end if;
        --
      end if;
      -- 
    end process;
    -- shared outport operator group (3) : simple_obj_ref_652_inst 
    OutportGroup3: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_652_inst_req_0;
      simple_obj_ref_652_inst_ack_0 <= ack(0);
      data_in <= tmp16_627;
      outport: OutputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => false)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => pkt_length_pipe_write_req(0),
          oack => pkt_length_pipe_write_ack(0),
          odata => pkt_length_pipe_write_data(31 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 3
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
entity wrapper_output is -- 
  generic (tag_length : integer); 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic;
    memory_space_3_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_3_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_3_lr_addr : out  std_logic_vector(10 downto 0);
    memory_space_3_lr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_3_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_3_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_3_lc_data : in   std_logic_vector(63 downto 0);
    memory_space_3_lc_tag :  in  std_logic_vector(1 downto 0);
    midpipe_pipe_read_req : out  std_logic_vector(0 downto 0);
    midpipe_pipe_read_ack : in   std_logic_vector(0 downto 0);
    midpipe_pipe_read_data : in   std_logic_vector(31 downto 0);
    last_ctrl_pipe_read_req : out  std_logic_vector(0 downto 0);
    last_ctrl_pipe_read_ack : in   std_logic_vector(0 downto 0);
    last_ctrl_pipe_read_data : in   std_logic_vector(7 downto 0);
    pkt_length_pipe_read_req : out  std_logic_vector(0 downto 0);
    pkt_length_pipe_read_ack : in   std_logic_vector(0 downto 0);
    pkt_length_pipe_read_data : in   std_logic_vector(31 downto 0);
    free_queue_request_pipe_write_req : out  std_logic_vector(0 downto 0);
    free_queue_request_pipe_write_ack : in   std_logic_vector(0 downto 0);
    free_queue_request_pipe_write_data : out  std_logic_vector(7 downto 0);
    free_queue_put_pipe_write_req : out  std_logic_vector(0 downto 0);
    free_queue_put_pipe_write_ack : in   std_logic_vector(0 downto 0);
    free_queue_put_pipe_write_data : out  std_logic_vector(31 downto 0);
    op_lut_ctrl_pipe_write_req : out  std_logic_vector(0 downto 0);
    op_lut_ctrl_pipe_write_ack : in   std_logic_vector(0 downto 0);
    op_lut_ctrl_pipe_write_data : out  std_logic_vector(7 downto 0);
    op_lut_data_pipe_write_req : out  std_logic_vector(0 downto 0);
    op_lut_data_pipe_write_ack : in   std_logic_vector(0 downto 0);
    op_lut_data_pipe_write_data : out  std_logic_vector(63 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
  );
  -- 
end entity wrapper_output;
architecture Default of wrapper_output is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal start_req_symbol: Boolean;
  signal start_ack_symbol: Boolean;
  signal fin_req_symbol: Boolean;
  signal fin_ack_symbol: Boolean;
  signal tag_push, tag_pop: std_logic; 
  signal start_ack_sig, fin_ack_sig: std_logic; 
  -- output port buffer signals
  signal wrapper_output_CP_2003_start: Boolean;
  -- links between control-path and data-path
  signal array_obj_ref_731_base_resize_ack_0 : boolean;
  signal simple_obj_ref_703_inst_ack_0 : boolean;
  signal ptr_deref_695_gather_scatter_ack_0 : boolean;
  signal ptr_deref_735_load_0_ack_1 : boolean;
  signal binary_726_inst_req_0 : boolean;
  signal simple_obj_ref_713_inst_req_0 : boolean;
  signal type_cast_673_inst_ack_0 : boolean;
  signal type_cast_673_inst_req_0 : boolean;
  signal simple_obj_ref_691_inst_ack_0 : boolean;
  signal ptr_deref_735_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_691_inst_req_0 : boolean;
  signal ptr_deref_695_addr_0_req_0 : boolean;
  signal ptr_deref_695_addr_0_ack_0 : boolean;
  signal ptr_deref_695_root_address_inst_ack_0 : boolean;
  signal simple_obj_ref_669_inst_ack_0 : boolean;
  signal ptr_deref_695_root_address_inst_req_0 : boolean;
  signal simple_obj_ref_669_inst_req_0 : boolean;
  signal ptr_deref_695_base_resize_ack_0 : boolean;
  signal array_obj_ref_731_root_address_inst_ack_0 : boolean;
  signal simple_obj_ref_682_inst_ack_0 : boolean;
  signal array_obj_ref_731_root_address_inst_req_1 : boolean;
  signal ptr_deref_695_base_resize_req_0 : boolean;
  signal array_obj_ref_731_root_address_inst_ack_1 : boolean;
  signal ptr_deref_735_base_resize_ack_0 : boolean;
  signal simple_obj_ref_703_inst_req_0 : boolean;
  signal array_obj_ref_731_final_reg_req_0 : boolean;
  signal binary_726_inst_ack_1 : boolean;
  signal array_obj_ref_731_base_resize_req_0 : boolean;
  signal simple_obj_ref_682_inst_req_0 : boolean;
  signal binary_726_inst_ack_0 : boolean;
  signal if_stmt_737_branch_ack_0 : boolean;
  signal binary_720_inst_req_0 : boolean;
  signal binary_720_inst_ack_0 : boolean;
  signal binary_720_inst_req_1 : boolean;
  signal ptr_deref_695_load_0_ack_0 : boolean;
  signal ptr_deref_695_gather_scatter_req_0 : boolean;
  signal array_obj_ref_731_root_address_inst_req_0 : boolean;
  signal ptr_deref_695_load_0_req_0 : boolean;
  signal binary_720_inst_ack_1 : boolean;
  signal array_obj_ref_731_final_reg_ack_0 : boolean;
  signal ptr_deref_735_load_0_req_0 : boolean;
  signal ptr_deref_735_gather_scatter_req_0 : boolean;
  signal binary_726_inst_req_1 : boolean;
  signal binary_763_inst_req_0 : boolean;
  signal ptr_deref_735_base_resize_req_0 : boolean;
  signal ptr_deref_735_addr_0_ack_0 : boolean;
  signal ptr_deref_735_addr_0_req_0 : boolean;
  signal binary_763_inst_ack_0 : boolean;
  signal binary_763_inst_req_1 : boolean;
  signal if_stmt_737_branch_ack_1 : boolean;
  signal if_stmt_737_branch_req_0 : boolean;
  signal simple_obj_ref_713_inst_ack_0 : boolean;
  signal ptr_deref_695_load_0_ack_1 : boolean;
  signal ptr_deref_735_load_0_req_1 : boolean;
  signal ptr_deref_735_load_0_ack_0 : boolean;
  signal ptr_deref_735_root_address_inst_ack_0 : boolean;
  signal ptr_deref_735_root_address_inst_req_0 : boolean;
  signal ptr_deref_695_load_0_req_1 : boolean;
  signal binary_763_inst_ack_1 : boolean;
  signal simple_obj_ref_771_inst_req_0 : boolean;
  signal simple_obj_ref_771_inst_ack_0 : boolean;
  signal simple_obj_ref_781_inst_req_0 : boolean;
  signal simple_obj_ref_781_inst_ack_0 : boolean;
  signal type_cast_786_inst_req_0 : boolean;
  signal type_cast_786_inst_ack_0 : boolean;
  signal binary_791_inst_req_0 : boolean;
  signal binary_791_inst_ack_0 : boolean;
  signal binary_791_inst_req_1 : boolean;
  signal binary_791_inst_ack_1 : boolean;
  signal array_obj_ref_795_index_0_resize_req_0 : boolean;
  signal array_obj_ref_795_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_795_index_0_rename_req_0 : boolean;
  signal array_obj_ref_795_index_0_rename_ack_0 : boolean;
  signal array_obj_ref_795_offset_inst_req_0 : boolean;
  signal array_obj_ref_795_offset_inst_ack_0 : boolean;
  signal array_obj_ref_795_base_resize_req_0 : boolean;
  signal array_obj_ref_795_base_resize_ack_0 : boolean;
  signal array_obj_ref_795_root_address_inst_req_0 : boolean;
  signal array_obj_ref_795_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_795_root_address_inst_req_1 : boolean;
  signal array_obj_ref_795_root_address_inst_ack_1 : boolean;
  signal array_obj_ref_795_final_reg_req_0 : boolean;
  signal array_obj_ref_795_final_reg_ack_0 : boolean;
  signal ptr_deref_799_base_resize_req_0 : boolean;
  signal ptr_deref_799_base_resize_ack_0 : boolean;
  signal ptr_deref_799_root_address_inst_req_0 : boolean;
  signal ptr_deref_799_root_address_inst_ack_0 : boolean;
  signal ptr_deref_799_addr_0_req_0 : boolean;
  signal ptr_deref_799_addr_0_ack_0 : boolean;
  signal ptr_deref_799_load_0_req_0 : boolean;
  signal ptr_deref_799_load_0_ack_0 : boolean;
  signal ptr_deref_799_load_0_req_1 : boolean;
  signal ptr_deref_799_load_0_ack_1 : boolean;
  signal ptr_deref_799_gather_scatter_req_0 : boolean;
  signal ptr_deref_799_gather_scatter_ack_0 : boolean;
  signal binary_805_inst_req_0 : boolean;
  signal binary_805_inst_ack_0 : boolean;
  signal binary_805_inst_req_1 : boolean;
  signal binary_805_inst_ack_1 : boolean;
  signal if_stmt_807_branch_req_0 : boolean;
  signal if_stmt_807_branch_ack_1 : boolean;
  signal if_stmt_807_branch_ack_0 : boolean;
  signal simple_obj_ref_827_inst_req_0 : boolean;
  signal simple_obj_ref_827_inst_ack_0 : boolean;
  signal simple_obj_ref_836_inst_req_0 : boolean;
  signal simple_obj_ref_836_inst_ack_0 : boolean;
  signal simple_obj_ref_845_inst_req_0 : boolean;
  signal simple_obj_ref_845_inst_ack_0 : boolean;
  signal simple_obj_ref_855_inst_req_0 : boolean;
  signal simple_obj_ref_855_inst_ack_0 : boolean;
  signal type_cast_748_inst_req_0 : boolean;
  signal type_cast_748_inst_ack_0 : boolean;
  signal phi_stmt_744_req_0 : boolean;
  signal type_cast_755_inst_req_0 : boolean;
  signal type_cast_755_inst_ack_0 : boolean;
  signal phi_stmt_752_req_0 : boolean;
  signal phi_stmt_744_req_1 : boolean;
  signal type_cast_757_inst_req_0 : boolean;
  signal type_cast_757_inst_ack_0 : boolean;
  signal phi_stmt_752_req_1 : boolean;
  signal phi_stmt_744_ack_0 : boolean;
  signal phi_stmt_752_ack_0 : boolean;
  signal type_cast_819_inst_req_0 : boolean;
  signal type_cast_819_inst_ack_0 : boolean;
  signal phi_stmt_814_req_1 : boolean;
  signal type_cast_817_inst_req_0 : boolean;
  signal type_cast_817_inst_ack_0 : boolean;
  signal phi_stmt_814_req_0 : boolean;
  signal phi_stmt_814_ack_0 : boolean;
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
  wrapper_output_CP_2003: Block -- control-path 
    signal cp_elements: BooleanArray(112 downto 0);
    -- 
  begin -- 
    cp_elements(0) <= start_req_symbol;
    start_ack_symbol <= cp_elements(1);
    finAckJoin: join2 port map(pred0 => fin_req_symbol, pred1 => cp_elements(1), symbol_out => fin_ack_symbol, clk => clk, reset => reset);
    cp_elements(1) <= false; 
    cp_elements(2) <= OrReduce(cp_elements(77) & cp_elements(99));
    binary_763_inst_req_0 <= cp_elements(2);
    cp_elements(3) <= OrReduce(cp_elements(101) & cp_elements(112));
    simple_obj_ref_827_inst_req_0 <= cp_elements(3);
    cp_elements(4) <= simple_obj_ref_669_inst_ack_0;
    type_cast_673_inst_req_0 <= cp_elements(4);
    cp_elements(5) <= type_cast_673_inst_ack_0;
    simple_obj_ref_682_inst_req_0 <= cp_elements(5);
    cp_elements(6) <= simple_obj_ref_682_inst_ack_0;
    simple_obj_ref_691_inst_req_0 <= cp_elements(6);
    cp_elements(7) <= simple_obj_ref_691_inst_ack_0;
    ptr_deref_695_base_resize_req_0 <= cp_elements(7);
    cp_elements(8) <= ptr_deref_695_base_resize_ack_0;
    ptr_deref_695_root_address_inst_req_0 <= cp_elements(8);
    cp_elements(9) <= ptr_deref_695_root_address_inst_ack_0;
    ptr_deref_695_addr_0_req_0 <= cp_elements(9);
    cp_elements(10) <= ptr_deref_695_addr_0_ack_0;
    ptr_deref_695_load_0_req_0 <= cp_elements(10);
    cp_elements(11) <= ptr_deref_695_load_0_ack_0;
    ptr_deref_695_load_0_req_1 <= cp_elements(11);
    cp_elements(12) <= ptr_deref_695_load_0_ack_1;
    ptr_deref_695_gather_scatter_req_0 <= cp_elements(12);
    cp_elements(13) <= ptr_deref_695_gather_scatter_ack_0;
    simple_obj_ref_703_inst_req_0 <= cp_elements(13);
    cp_elements(14) <= simple_obj_ref_703_inst_ack_0;
    simple_obj_ref_713_inst_req_0 <= cp_elements(14);
    cp_elements(15) <= simple_obj_ref_713_inst_ack_0;
    binary_720_inst_req_0 <= cp_elements(15);
    cp_elements(16) <= binary_720_inst_ack_0;
    binary_720_inst_req_1 <= cp_elements(16);
    cp_elements(17) <= binary_720_inst_ack_1;
    binary_726_inst_req_0 <= cp_elements(17);
    cp_elements(18) <= binary_726_inst_ack_0;
    binary_726_inst_req_1 <= cp_elements(18);
    cp_elements(19) <= binary_726_inst_ack_1;
    array_obj_ref_731_base_resize_req_0 <= cp_elements(19);
    cp_elements(20) <= array_obj_ref_731_base_resize_ack_0;
    array_obj_ref_731_root_address_inst_req_0 <= cp_elements(20);
    cp_elements(21) <= array_obj_ref_731_root_address_inst_ack_0;
    array_obj_ref_731_root_address_inst_req_1 <= cp_elements(21);
    cp_elements(22) <= array_obj_ref_731_root_address_inst_ack_1;
    array_obj_ref_731_final_reg_req_0 <= cp_elements(22);
    cp_elements(23) <= array_obj_ref_731_final_reg_ack_0;
    ptr_deref_735_base_resize_req_0 <= cp_elements(23);
    cp_elements(24) <= ptr_deref_735_base_resize_ack_0;
    ptr_deref_735_root_address_inst_req_0 <= cp_elements(24);
    cp_elements(25) <= ptr_deref_735_root_address_inst_ack_0;
    ptr_deref_735_addr_0_req_0 <= cp_elements(25);
    cp_elements(26) <= ptr_deref_735_addr_0_ack_0;
    ptr_deref_735_load_0_req_0 <= cp_elements(26);
    cp_elements(27) <= ptr_deref_735_load_0_ack_0;
    ptr_deref_735_load_0_req_1 <= cp_elements(27);
    cp_elements(28) <= ptr_deref_735_load_0_ack_1;
    ptr_deref_735_gather_scatter_req_0 <= cp_elements(28);
    cp_elements(29) <= ptr_deref_735_gather_scatter_ack_0;
    cp_elements(30) <= cp_elements(29);
    cp_elements(31) <= false;
    cp_elements(32) <= cp_elements(31);
    cp_elements(33) <= cp_elements(29);
    if_stmt_737_branch_req_0 <= cp_elements(33);
    cp_elements(34) <= cp_elements(33);
    cp_elements(35) <= cp_elements(34);
    cp_elements(36) <= if_stmt_737_branch_ack_1;
    cp_elements(37) <= cp_elements(34);
    cp_elements(38) <= if_stmt_737_branch_ack_0;
    cp_elements(39) <= binary_763_inst_ack_0;
    binary_763_inst_req_1 <= cp_elements(39);
    cp_elements(40) <= binary_763_inst_ack_1;
    simple_obj_ref_771_inst_req_0 <= cp_elements(40);
    cp_elements(41) <= simple_obj_ref_771_inst_ack_0;
    simple_obj_ref_781_inst_req_0 <= cp_elements(41);
    cp_elements(42) <= simple_obj_ref_781_inst_ack_0;
    type_cast_786_inst_req_0 <= cp_elements(42);
    cp_elements(43) <= type_cast_786_inst_ack_0;
    binary_791_inst_req_0 <= cp_elements(43);
    cp_elements(44) <= binary_791_inst_ack_0;
    binary_791_inst_req_1 <= cp_elements(44);
    cp_elements(45) <= binary_791_inst_ack_1;
    array_obj_ref_795_index_0_resize_req_0 <= cp_elements(45);
    cp_elements(46) <= array_obj_ref_795_index_0_resize_ack_0;
    array_obj_ref_795_index_0_rename_req_0 <= cp_elements(46);
    cp_elements(47) <= array_obj_ref_795_index_0_rename_ack_0;
    array_obj_ref_795_offset_inst_req_0 <= cp_elements(47);
    cp_elements(48) <= array_obj_ref_795_offset_inst_ack_0;
    array_obj_ref_795_base_resize_req_0 <= cp_elements(48);
    cp_elements(49) <= array_obj_ref_795_base_resize_ack_0;
    array_obj_ref_795_root_address_inst_req_0 <= cp_elements(49);
    cp_elements(50) <= array_obj_ref_795_root_address_inst_ack_0;
    array_obj_ref_795_root_address_inst_req_1 <= cp_elements(50);
    cp_elements(51) <= array_obj_ref_795_root_address_inst_ack_1;
    array_obj_ref_795_final_reg_req_0 <= cp_elements(51);
    cp_elements(52) <= array_obj_ref_795_final_reg_ack_0;
    ptr_deref_799_base_resize_req_0 <= cp_elements(52);
    cp_elements(53) <= ptr_deref_799_base_resize_ack_0;
    ptr_deref_799_root_address_inst_req_0 <= cp_elements(53);
    cp_elements(54) <= ptr_deref_799_root_address_inst_ack_0;
    ptr_deref_799_addr_0_req_0 <= cp_elements(54);
    cp_elements(55) <= ptr_deref_799_addr_0_ack_0;
    ptr_deref_799_load_0_req_0 <= cp_elements(55);
    cp_elements(56) <= ptr_deref_799_load_0_ack_0;
    ptr_deref_799_load_0_req_1 <= cp_elements(56);
    cp_elements(57) <= ptr_deref_799_load_0_ack_1;
    ptr_deref_799_gather_scatter_req_0 <= cp_elements(57);
    cp_elements(58) <= ptr_deref_799_gather_scatter_ack_0;
    binary_805_inst_req_0 <= cp_elements(58);
    cp_elements(59) <= binary_805_inst_ack_0;
    binary_805_inst_req_1 <= cp_elements(59);
    cp_elements(60) <= binary_805_inst_ack_1;
    cp_elements(61) <= cp_elements(60);
    cp_elements(62) <= false;
    cp_elements(63) <= cp_elements(62);
    cp_elements(64) <= cp_elements(60);
    if_stmt_807_branch_req_0 <= cp_elements(64);
    cp_elements(65) <= cp_elements(64);
    cp_elements(66) <= cp_elements(65);
    cp_elements(67) <= if_stmt_807_branch_ack_1;
    cp_elements(68) <= cp_elements(65);
    cp_elements(69) <= if_stmt_807_branch_ack_0;
    cp_elements(70) <= simple_obj_ref_827_inst_ack_0;
    simple_obj_ref_836_inst_req_0 <= cp_elements(70);
    cp_elements(71) <= simple_obj_ref_836_inst_ack_0;
    simple_obj_ref_845_inst_req_0 <= cp_elements(71);
    cp_elements(72) <= simple_obj_ref_845_inst_ack_0;
    simple_obj_ref_855_inst_req_0 <= cp_elements(72);
    cp_elements(73) <= simple_obj_ref_855_inst_ack_0;
    cp_elements(74) <= OrReduce(cp_elements(0) & cp_elements(73));
    cp_elements(75) <= cp_elements(74);
    simple_obj_ref_669_inst_req_0 <= cp_elements(75);
    cp_elements(76) <= false;
    cp_elements(77) <= cp_elements(76);
    cp_elements(78) <= cp_elements(67);
    cp_elements(79) <= cp_elements(78);
    type_cast_748_inst_req_0 <= cp_elements(79);
    cp_elements(80) <= type_cast_748_inst_ack_0;
    phi_stmt_744_req_0 <= cp_elements(80);
    cp_elements(81) <= cp_elements(78);
    cp_elements(82) <= cp_elements(81);
    type_cast_755_inst_req_0 <= cp_elements(82);
    cp_elements(83) <= type_cast_755_inst_ack_0;
    cp_elements(84) <= cp_elements(81);
    cpelement_group_85 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(83) & cp_elements(84));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(85),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_752_req_0 <= cp_elements(85);
    cpelement_group_86 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(80) & cp_elements(85));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(86),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(87) <= cp_elements(36);
    cp_elements(88) <= cp_elements(87);
    phi_stmt_744_req_1 <= cp_elements(88);
    cp_elements(89) <= cp_elements(87);
    cp_elements(90) <= cp_elements(89);
    cp_elements(91) <= cp_elements(89);
    type_cast_757_inst_req_0 <= cp_elements(91);
    cp_elements(92) <= type_cast_757_inst_ack_0;
    cpelement_group_93 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(90) & cp_elements(92));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(93),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_752_req_1 <= cp_elements(93);
    cpelement_group_94 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(88) & cp_elements(93));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(94),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(95) <= OrReduce(cp_elements(86) & cp_elements(94));
    cp_elements(96) <= cp_elements(95);
    cp_elements(97) <= phi_stmt_744_ack_0;
    cp_elements(98) <= phi_stmt_752_ack_0;
    cpelement_group_99 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(97) & cp_elements(98));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(99),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(100) <= false;
    cp_elements(101) <= cp_elements(100);
    cp_elements(102) <= cp_elements(69);
    cp_elements(103) <= cp_elements(69);
    type_cast_819_inst_req_0 <= cp_elements(103);
    cp_elements(104) <= type_cast_819_inst_ack_0;
    cpelement_group_105 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(102) & cp_elements(104));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(105),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_814_req_1 <= cp_elements(105);
    cp_elements(106) <= cp_elements(38);
    type_cast_817_inst_req_0 <= cp_elements(106);
    cp_elements(107) <= type_cast_817_inst_ack_0;
    cp_elements(108) <= cp_elements(38);
    cpelement_group_109 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(107) & cp_elements(108));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(109),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_814_req_0 <= cp_elements(109);
    cp_elements(110) <= OrReduce(cp_elements(105) & cp_elements(109));
    cp_elements(111) <= cp_elements(110);
    cp_elements(112) <= phi_stmt_814_ack_0;
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal array_obj_ref_731_final_offset : std_logic_vector(10 downto 0);
    signal array_obj_ref_731_resized_base_address : std_logic_vector(10 downto 0);
    signal array_obj_ref_731_root_address : std_logic_vector(10 downto 0);
    signal array_obj_ref_795_final_offset : std_logic_vector(10 downto 0);
    signal array_obj_ref_795_offset_scale_factor_0 : std_logic_vector(10 downto 0);
    signal array_obj_ref_795_resized_base_address : std_logic_vector(10 downto 0);
    signal array_obj_ref_795_root_address : std_logic_vector(10 downto 0);
    signal iNsTr_11_780 : std_logic_vector(31 downto 0);
    signal iNsTr_14_826 : std_logic_vector(31 downto 0);
    signal iNsTr_16_835 : std_logic_vector(31 downto 0);
    signal iNsTr_18_844 : std_logic_vector(31 downto 0);
    signal iNsTr_1_667 : std_logic_vector(31 downto 0);
    signal iNsTr_20_854 : std_logic_vector(31 downto 0);
    signal iNsTr_2_680 : std_logic_vector(31 downto 0);
    signal iNsTr_3_689 : std_logic_vector(31 downto 0);
    signal iNsTr_4_702 : std_logic_vector(31 downto 0);
    signal iNsTr_6_712 : std_logic_vector(31 downto 0);
    signal iNsTr_9_770 : std_logic_vector(31 downto 0);
    signal indvar_744 : std_logic_vector(15 downto 0);
    signal indvarx_xnext_806 : std_logic_vector(15 downto 0);
    signal ptr_deref_695_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_695_resized_base_address : std_logic_vector(10 downto 0);
    signal ptr_deref_695_root_address : std_logic_vector(10 downto 0);
    signal ptr_deref_695_word_address_0 : std_logic_vector(10 downto 0);
    signal ptr_deref_695_word_offset_0 : std_logic_vector(10 downto 0);
    signal ptr_deref_735_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_735_resized_base_address : std_logic_vector(10 downto 0);
    signal ptr_deref_735_root_address : std_logic_vector(10 downto 0);
    signal ptr_deref_735_word_address_0 : std_logic_vector(10 downto 0);
    signal ptr_deref_735_word_offset_0 : std_logic_vector(10 downto 0);
    signal ptr_deref_799_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_799_resized_base_address : std_logic_vector(10 downto 0);
    signal ptr_deref_799_root_address : std_logic_vector(10 downto 0);
    signal ptr_deref_799_word_address_0 : std_logic_vector(10 downto 0);
    signal ptr_deref_799_word_offset_0 : std_logic_vector(10 downto 0);
    signal simple_obj_ref_794_resized : std_logic_vector(10 downto 0);
    signal simple_obj_ref_794_scaled : std_logic_vector(10 downto 0);
    signal tmp1224_732 : std_logic_vector(31 downto 0);
    signal tmp12_796 : std_logic_vector(31 downto 0);
    signal tmp1325_736 : std_logic_vector(63 downto 0);
    signal tmp1327_752 : std_logic_vector(63 downto 0);
    signal tmp13_800 : std_logic_vector(63 downto 0);
    signal tmp13x_xlcssa_814 : std_logic_vector(63 downto 0);
    signal tmp14_764 : std_logic_vector(15 downto 0);
    signal tmp2_674 : std_logic_vector(31 downto 0);
    signal tmp3_683 : std_logic_vector(31 downto 0);
    signal tmp4_692 : std_logic_vector(7 downto 0);
    signal tmp5_696 : std_logic_vector(63 downto 0);
    signal tmp7_787 : std_logic_vector(31 downto 0);
    signal tmp821_721 : std_logic_vector(31 downto 0);
    signal tmp922_727 : std_logic_vector(0 downto 0);
    signal tmp9_792 : std_logic_vector(0 downto 0);
    signal tmp_670 : std_logic_vector(31 downto 0);
    signal type_cast_705_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_719_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_725_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_748_wire : std_logic_vector(15 downto 0);
    signal type_cast_751_wire_constant : std_logic_vector(15 downto 0);
    signal type_cast_755_wire : std_logic_vector(63 downto 0);
    signal type_cast_757_wire : std_logic_vector(63 downto 0);
    signal type_cast_762_wire_constant : std_logic_vector(15 downto 0);
    signal type_cast_773_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_804_wire_constant : std_logic_vector(15 downto 0);
    signal type_cast_817_wire : std_logic_vector(63 downto 0);
    signal type_cast_819_wire : std_logic_vector(63 downto 0);
    signal type_cast_847_wire_constant : std_logic_vector(7 downto 0);
    -- 
  begin -- 
    array_obj_ref_731_final_offset <= "00000000001";
    array_obj_ref_795_offset_scale_factor_0 <= "00000000001";
    iNsTr_11_780 <= "00000000000000000000000000000000";
    iNsTr_14_826 <= "00000000000000000000000000000000";
    iNsTr_16_835 <= "00000000000000000000000000000000";
    iNsTr_18_844 <= "00000000000000000000000000000000";
    iNsTr_1_667 <= "00000000000000000000000000000000";
    iNsTr_20_854 <= "00000000000000000000000000000000";
    iNsTr_2_680 <= "00000000000000000000000000000000";
    iNsTr_3_689 <= "00000000000000000000000000000000";
    iNsTr_4_702 <= "00000000000000000000000000000000";
    iNsTr_6_712 <= "00000000000000000000000000000000";
    iNsTr_9_770 <= "00000000000000000000000000000000";
    ptr_deref_695_word_offset_0 <= "00000000000";
    ptr_deref_735_word_offset_0 <= "00000000000";
    ptr_deref_799_word_offset_0 <= "00000000000";
    type_cast_705_wire_constant <= "11111111";
    type_cast_719_wire_constant <= "11111111111111111111111111111111";
    type_cast_725_wire_constant <= "00000000000000000000000000000001";
    type_cast_751_wire_constant <= "0000000000000000";
    type_cast_762_wire_constant <= "0000000000000010";
    type_cast_773_wire_constant <= "00000000";
    type_cast_804_wire_constant <= "0000000000000001";
    type_cast_847_wire_constant <= "00000001";
    phi_stmt_744: Block -- phi operator 
      signal idata: std_logic_vector(31 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_748_wire & type_cast_751_wire_constant;
      req <= phi_stmt_744_req_0 & phi_stmt_744_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 16) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_744_ack_0,
          idata => idata,
          odata => indvar_744,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_744
    phi_stmt_752: Block -- phi operator 
      signal idata: std_logic_vector(127 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_755_wire & type_cast_757_wire;
      req <= phi_stmt_752_req_0 & phi_stmt_752_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 64) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_752_ack_0,
          idata => idata,
          odata => tmp1327_752,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_752
    phi_stmt_814: Block -- phi operator 
      signal idata: std_logic_vector(127 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_817_wire & type_cast_819_wire;
      req <= phi_stmt_814_req_0 & phi_stmt_814_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 64) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_814_ack_0,
          idata => idata,
          odata => tmp13x_xlcssa_814,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_814
    array_obj_ref_731_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 11, flow_through => true ) 
      port map( din => tmp2_674, dout => array_obj_ref_731_resized_base_address, req => array_obj_ref_731_base_resize_req_0, ack => array_obj_ref_731_base_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_731_final_reg: RegisterBase --
      generic map(in_data_width => 11,out_data_width => 32, flow_through => false ) 
      port map( din => array_obj_ref_731_root_address, dout => tmp1224_732, req => array_obj_ref_731_final_reg_req_0, ack => array_obj_ref_731_final_reg_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_795_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 11, flow_through => true ) 
      port map( din => tmp2_674, dout => array_obj_ref_795_resized_base_address, req => array_obj_ref_795_base_resize_req_0, ack => array_obj_ref_795_base_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_795_final_reg: RegisterBase --
      generic map(in_data_width => 11,out_data_width => 32, flow_through => false ) 
      port map( din => array_obj_ref_795_root_address, dout => tmp12_796, req => array_obj_ref_795_final_reg_req_0, ack => array_obj_ref_795_final_reg_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_795_index_0_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 11, flow_through => true ) 
      port map( din => tmp7_787, dout => simple_obj_ref_794_resized, req => array_obj_ref_795_index_0_resize_req_0, ack => array_obj_ref_795_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_795_offset_inst: RegisterBase --
      generic map(in_data_width => 11,out_data_width => 11, flow_through => true ) 
      port map( din => simple_obj_ref_794_scaled, dout => array_obj_ref_795_final_offset, req => array_obj_ref_795_offset_inst_req_0, ack => array_obj_ref_795_offset_inst_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_695_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 11, flow_through => true ) 
      port map( din => tmp2_674, dout => ptr_deref_695_resized_base_address, req => ptr_deref_695_base_resize_req_0, ack => ptr_deref_695_base_resize_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_735_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 11, flow_through => true ) 
      port map( din => tmp1224_732, dout => ptr_deref_735_resized_base_address, req => ptr_deref_735_base_resize_req_0, ack => ptr_deref_735_base_resize_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_799_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 11, flow_through => true ) 
      port map( din => tmp12_796, dout => ptr_deref_799_resized_base_address, req => ptr_deref_799_base_resize_req_0, ack => ptr_deref_799_base_resize_ack_0, clk => clk, reset => reset); -- 
    type_cast_673_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => false ) 
      port map( din => tmp_670, dout => tmp2_674, req => type_cast_673_inst_req_0, ack => type_cast_673_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_748_inst: RegisterBase --
      generic map(in_data_width => 16,out_data_width => 16, flow_through => true ) 
      port map( din => indvarx_xnext_806, dout => type_cast_748_wire, req => type_cast_748_inst_req_0, ack => type_cast_748_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_755_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => tmp13_800, dout => type_cast_755_wire, req => type_cast_755_inst_req_0, ack => type_cast_755_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_757_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => tmp1325_736, dout => type_cast_757_wire, req => type_cast_757_inst_req_0, ack => type_cast_757_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_786_inst: RegisterBase --
      generic map(in_data_width => 16,out_data_width => 32, flow_through => false ) 
      port map( din => tmp14_764, dout => tmp7_787, req => type_cast_786_inst_req_0, ack => type_cast_786_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_817_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => tmp1325_736, dout => type_cast_817_wire, req => type_cast_817_inst_req_0, ack => type_cast_817_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_819_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => tmp13_800, dout => type_cast_819_wire, req => type_cast_819_inst_req_0, ack => type_cast_819_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_795_index_0_rename: Block -- 
      signal aggregated_sig: std_logic_vector(10 downto 0); --
    begin -- 
      array_obj_ref_795_index_0_rename_ack_0 <= array_obj_ref_795_index_0_rename_req_0;
      aggregated_sig <= simple_obj_ref_794_resized;
      simple_obj_ref_794_scaled <= aggregated_sig(10 downto 0);
      --
    end Block;
    ptr_deref_695_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(10 downto 0); --
    begin -- 
      ptr_deref_695_addr_0_ack_0 <= ptr_deref_695_addr_0_req_0;
      aggregated_sig <= ptr_deref_695_root_address;
      ptr_deref_695_word_address_0 <= aggregated_sig(10 downto 0);
      --
    end Block;
    ptr_deref_695_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_695_gather_scatter_ack_0 <= ptr_deref_695_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_695_data_0;
      tmp5_696 <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_695_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(10 downto 0); --
    begin -- 
      ptr_deref_695_root_address_inst_ack_0 <= ptr_deref_695_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_695_resized_base_address;
      ptr_deref_695_root_address <= aggregated_sig(10 downto 0);
      --
    end Block;
    ptr_deref_735_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(10 downto 0); --
    begin -- 
      ptr_deref_735_addr_0_ack_0 <= ptr_deref_735_addr_0_req_0;
      aggregated_sig <= ptr_deref_735_root_address;
      ptr_deref_735_word_address_0 <= aggregated_sig(10 downto 0);
      --
    end Block;
    ptr_deref_735_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_735_gather_scatter_ack_0 <= ptr_deref_735_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_735_data_0;
      tmp1325_736 <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_735_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(10 downto 0); --
    begin -- 
      ptr_deref_735_root_address_inst_ack_0 <= ptr_deref_735_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_735_resized_base_address;
      ptr_deref_735_root_address <= aggregated_sig(10 downto 0);
      --
    end Block;
    ptr_deref_799_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(10 downto 0); --
    begin -- 
      ptr_deref_799_addr_0_ack_0 <= ptr_deref_799_addr_0_req_0;
      aggregated_sig <= ptr_deref_799_root_address;
      ptr_deref_799_word_address_0 <= aggregated_sig(10 downto 0);
      --
    end Block;
    ptr_deref_799_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_799_gather_scatter_ack_0 <= ptr_deref_799_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_799_data_0;
      tmp13_800 <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_799_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(10 downto 0); --
    begin -- 
      ptr_deref_799_root_address_inst_ack_0 <= ptr_deref_799_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_799_resized_base_address;
      ptr_deref_799_root_address <= aggregated_sig(10 downto 0);
      --
    end Block;
    if_stmt_737_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= tmp922_727;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_737_branch_req_0,
          ack0 => if_stmt_737_branch_ack_0,
          ack1 => if_stmt_737_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    if_stmt_807_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= tmp9_792;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_807_branch_req_0,
          ack0 => if_stmt_807_branch_ack_0,
          ack1 => if_stmt_807_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : array_obj_ref_731_root_address_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(10 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= array_obj_ref_731_resized_base_address;
      array_obj_ref_731_root_address <= data_out(10 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 11,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 11,
          constant_operand => "00000000001",
          constant_width => 11,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => array_obj_ref_731_root_address_inst_req_0,
          ackL => array_obj_ref_731_root_address_inst_ack_0,
          reqR => array_obj_ref_731_root_address_inst_req_1,
          ackR => array_obj_ref_731_root_address_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : array_obj_ref_795_root_address_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(21 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= array_obj_ref_795_final_offset & array_obj_ref_795_resized_base_address;
      array_obj_ref_795_root_address <= data_out(10 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 11,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 11, 
          num_inputs    => 2,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 11,
          constant_operand => "0",
          constant_width => 1,
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => array_obj_ref_795_root_address_inst_req_0,
          ackL => array_obj_ref_795_root_address_inst_ack_0,
          reqR => array_obj_ref_795_root_address_inst_req_1,
          ackR => array_obj_ref_795_root_address_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : binary_720_inst 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp3_683;
      tmp821_721 <= data_out(31 downto 0);
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
          constant_operand => "11111111111111111111111111111111",
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_720_inst_req_0,
          ackL => binary_720_inst_ack_0,
          reqR => binary_720_inst_req_1,
          ackR => binary_720_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : binary_726_inst 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp821_721;
      tmp922_727 <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntUgt",
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
          constant_operand => "00000000000000000000000000000001",
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_726_inst_req_0,
          ackL => binary_726_inst_ack_0,
          reqR => binary_726_inst_req_1,
          ackR => binary_726_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : binary_763_inst 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(15 downto 0);
      signal data_out: std_logic_vector(15 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= indvar_744;
      tmp14_764 <= data_out(15 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 16,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 16,
          constant_operand => "0000000000000010",
          constant_width => 16,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_763_inst_req_0,
          ackL => binary_763_inst_ack_0,
          reqR => binary_763_inst_req_1,
          ackR => binary_763_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared split operator group (5) : binary_791_inst 
    SplitOperatorGroup5: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp7_787 & tmp821_721;
      tmp9_792 <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntUlt",
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
          owidth => 1,
          constant_operand => "0",
          constant_width => 1,
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_791_inst_req_0,
          ackL => binary_791_inst_ack_0,
          reqR => binary_791_inst_req_1,
          ackR => binary_791_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 5
    -- shared split operator group (6) : binary_805_inst 
    SplitOperatorGroup6: Block -- 
      signal data_in: std_logic_vector(15 downto 0);
      signal data_out: std_logic_vector(15 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= indvar_744;
      indvarx_xnext_806 <= data_out(15 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 16,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 16,
          constant_operand => "0000000000000001",
          constant_width => 16,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_805_inst_req_0,
          ackL => binary_805_inst_ack_0,
          reqR => binary_805_inst_req_1,
          ackR => binary_805_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 6
    -- shared load operator group (0) : ptr_deref_735_load_0 ptr_deref_799_load_0 ptr_deref_695_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(32 downto 0);
      signal data_out: std_logic_vector(191 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 2 downto 0);
      -- 
    begin -- 
      -- logging on!
      process(clk)  begin -- 
        if clk'event and clk = '1' then -- 
          if ptr_deref_735_load_0_ack_1 then -- 
            assert false report " ReadMem memory_space_3 address ptr_deref_735_word_address_0 ="  &  convert_slv_to_hex_string(ptr_deref_735_word_address_0) &  " data ptr_deref_735_data_0 ="  &  convert_slv_to_hex_string(data_out(191 downto 128)) severity note; --
          end if;
          if ptr_deref_799_load_0_ack_1 then -- 
            assert false report " ReadMem memory_space_3 address ptr_deref_799_word_address_0 ="  &  convert_slv_to_hex_string(ptr_deref_799_word_address_0) &  " data ptr_deref_799_data_0 ="  &  convert_slv_to_hex_string(data_out(127 downto 64)) severity note; --
          end if;
          if ptr_deref_695_load_0_ack_1 then -- 
            assert false report " ReadMem memory_space_3 address ptr_deref_695_word_address_0 ="  &  convert_slv_to_hex_string(ptr_deref_695_word_address_0) &  " data ptr_deref_695_data_0 ="  &  convert_slv_to_hex_string(data_out(63 downto 0)) severity note; --
          end if;
          --
        end if;
        -- 
      end process;
      reqL(2) <= ptr_deref_735_load_0_req_0;
      reqL(1) <= ptr_deref_799_load_0_req_0;
      reqL(0) <= ptr_deref_695_load_0_req_0;
      ptr_deref_735_load_0_ack_0 <= ackL(2);
      ptr_deref_799_load_0_ack_0 <= ackL(1);
      ptr_deref_695_load_0_ack_0 <= ackL(0);
      reqR(2) <= ptr_deref_735_load_0_req_1;
      reqR(1) <= ptr_deref_799_load_0_req_1;
      reqR(0) <= ptr_deref_695_load_0_req_1;
      ptr_deref_735_load_0_ack_1 <= ackR(2);
      ptr_deref_799_load_0_ack_1 <= ackR(1);
      ptr_deref_695_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_735_word_address_0 & ptr_deref_799_word_address_0 & ptr_deref_695_word_address_0;
      ptr_deref_735_data_0 <= data_out(191 downto 128);
      ptr_deref_799_data_0 <= data_out(127 downto 64);
      ptr_deref_695_data_0 <= data_out(63 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 11,  num_reqs => 3,  tag_length => 2, min_clock_period => false,
        no_arbitration => false)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_3_lr_req(0),
          mack => memory_space_3_lr_ack(0),
          maddr => memory_space_3_lr_addr(10 downto 0),
          mtag => memory_space_3_lr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 64,  num_reqs => 3,  tag_length => 2,  no_arbitration => false)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_3_lc_req(0),
          mack => memory_space_3_lc_ack(0),
          mdata => memory_space_3_lc_data(63 downto 0),
          mtag => memory_space_3_lc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- shared inport operator group (0) : simple_obj_ref_669_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      -- logging on!
      process(clk)  begin -- 
        if clk'event and clk = '1' then -- 
          if simple_obj_ref_669_inst_ack_0 then -- 
            assert false report " ReadPipe midpipe to wire tmp_670 value="  &  convert_slv_to_hex_string(data_out(31 downto 0))  severity note; --
          end if;
          --
        end if;
        -- 
      end process;
      req(0) <= simple_obj_ref_669_inst_req_0;
      simple_obj_ref_669_inst_ack_0 <= ack(0);
      tmp_670 <= data_out(31 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => false)
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
    -- shared inport operator group (1) : simple_obj_ref_682_inst 
    InportGroup1: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      -- logging on!
      process(clk)  begin -- 
        if clk'event and clk = '1' then -- 
          if simple_obj_ref_682_inst_ack_0 then -- 
            assert false report " ReadPipe pkt_length to wire tmp3_683 value="  &  convert_slv_to_hex_string(data_out(31 downto 0))  severity note; --
          end if;
          --
        end if;
        -- 
      end process;
      req(0) <= simple_obj_ref_682_inst_req_0;
      simple_obj_ref_682_inst_ack_0 <= ack(0);
      tmp3_683 <= data_out(31 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => false)
        port map (-- 
          req => req , 
          ack => ack , 
          data => data_out, 
          oreq => pkt_length_pipe_read_req(0),
          oack => pkt_length_pipe_read_ack(0),
          odata => pkt_length_pipe_read_data(31 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 1
    -- shared inport operator group (2) : simple_obj_ref_691_inst 
    InportGroup2: Block -- 
      signal data_out: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      -- logging on!
      process(clk)  begin -- 
        if clk'event and clk = '1' then -- 
          if simple_obj_ref_691_inst_ack_0 then -- 
            assert false report " ReadPipe last_ctrl to wire tmp4_692 value="  &  convert_slv_to_hex_string(data_out(7 downto 0))  severity note; --
          end if;
          --
        end if;
        -- 
      end process;
      req(0) <= simple_obj_ref_691_inst_req_0;
      simple_obj_ref_691_inst_ack_0 <= ack(0);
      tmp4_692 <= data_out(7 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 8,  num_reqs => 1,  no_arbitration => false)
        port map (-- 
          req => req , 
          ack => ack , 
          data => data_out, 
          oreq => last_ctrl_pipe_read_req(0),
          oack => last_ctrl_pipe_read_ack(0),
          odata => last_ctrl_pipe_read_data(7 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 2
    -- logging on!
    process(clk)  begin -- 
      if clk'event and clk = '1' then -- 
        if simple_obj_ref_827_inst_ack_0 then -- 
          assert false report " WritePipe op_lut_ctrl from wire tmp4_692 value="  &  convert_slv_to_hex_string(tmp4_692) severity note; --
        end if;
        if simple_obj_ref_771_inst_ack_0 then -- 
          assert false report " WritePipe op_lut_ctrl from wire type_cast_773_wire_constant value="  &  convert_slv_to_hex_string(type_cast_773_wire_constant) severity note; --
        end if;
        if simple_obj_ref_703_inst_ack_0 then -- 
          assert false report " WritePipe op_lut_ctrl from wire type_cast_705_wire_constant value="  &  convert_slv_to_hex_string(type_cast_705_wire_constant) severity note; --
        end if;
        --
      end if;
      -- 
    end process;
    -- shared outport operator group (0) : simple_obj_ref_827_inst simple_obj_ref_771_inst simple_obj_ref_703_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(23 downto 0);
      signal req, ack : BooleanArray( 2 downto 0);
      -- 
    begin -- 
      req(2) <= simple_obj_ref_827_inst_req_0;
      req(1) <= simple_obj_ref_771_inst_req_0;
      req(0) <= simple_obj_ref_703_inst_req_0;
      simple_obj_ref_827_inst_ack_0 <= ack(2);
      simple_obj_ref_771_inst_ack_0 <= ack(1);
      simple_obj_ref_703_inst_ack_0 <= ack(0);
      data_in <= tmp4_692 & type_cast_773_wire_constant & type_cast_705_wire_constant;
      outport: OutputPort -- 
        generic map ( data_width => 8,  num_reqs => 3,  no_arbitration => false)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => op_lut_ctrl_pipe_write_req(0),
          oack => op_lut_ctrl_pipe_write_ack(0),
          odata => op_lut_ctrl_pipe_write_data(7 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    -- logging on!
    process(clk)  begin -- 
      if clk'event and clk = '1' then -- 
        if simple_obj_ref_836_inst_ack_0 then -- 
          assert false report " WritePipe op_lut_data from wire tmp13x_xlcssa_814 value="  &  convert_slv_to_hex_string(tmp13x_xlcssa_814) severity note; --
        end if;
        if simple_obj_ref_781_inst_ack_0 then -- 
          assert false report " WritePipe op_lut_data from wire tmp1327_752 value="  &  convert_slv_to_hex_string(tmp1327_752) severity note; --
        end if;
        if simple_obj_ref_713_inst_ack_0 then -- 
          assert false report " WritePipe op_lut_data from wire tmp5_696 value="  &  convert_slv_to_hex_string(tmp5_696) severity note; --
        end if;
        --
      end if;
      -- 
    end process;
    -- shared outport operator group (1) : simple_obj_ref_836_inst simple_obj_ref_781_inst simple_obj_ref_713_inst 
    OutportGroup1: Block -- 
      signal data_in: std_logic_vector(191 downto 0);
      signal req, ack : BooleanArray( 2 downto 0);
      -- 
    begin -- 
      req(2) <= simple_obj_ref_836_inst_req_0;
      req(1) <= simple_obj_ref_781_inst_req_0;
      req(0) <= simple_obj_ref_713_inst_req_0;
      simple_obj_ref_836_inst_ack_0 <= ack(2);
      simple_obj_ref_781_inst_ack_0 <= ack(1);
      simple_obj_ref_713_inst_ack_0 <= ack(0);
      data_in <= tmp13x_xlcssa_814 & tmp1327_752 & tmp5_696;
      outport: OutputPort -- 
        generic map ( data_width => 64,  num_reqs => 3,  no_arbitration => false)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => op_lut_data_pipe_write_req(0),
          oack => op_lut_data_pipe_write_ack(0),
          odata => op_lut_data_pipe_write_data(63 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 1
    -- logging on!
    process(clk)  begin -- 
      if clk'event and clk = '1' then -- 
        if simple_obj_ref_845_inst_ack_0 then -- 
          assert false report " WritePipe free_queue_request from wire type_cast_847_wire_constant value="  &  convert_slv_to_hex_string(type_cast_847_wire_constant) severity note; --
        end if;
        --
      end if;
      -- 
    end process;
    -- shared outport operator group (2) : simple_obj_ref_845_inst 
    OutportGroup2: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_845_inst_req_0;
      simple_obj_ref_845_inst_ack_0 <= ack(0);
      data_in <= type_cast_847_wire_constant;
      outport: OutputPort -- 
        generic map ( data_width => 8,  num_reqs => 1,  no_arbitration => false)
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
    end Block; -- outport group 2
    -- logging on!
    process(clk)  begin -- 
      if clk'event and clk = '1' then -- 
        if simple_obj_ref_855_inst_ack_0 then -- 
          assert false report " WritePipe free_queue_put from wire tmp_670 value="  &  convert_slv_to_hex_string(tmp_670) severity note; --
        end if;
        --
      end if;
      -- 
    end process;
    -- shared outport operator group (3) : simple_obj_ref_855_inst 
    OutportGroup3: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_855_inst_req_0;
      simple_obj_ref_855_inst_ack_0 <= ack(0);
      data_in <= tmp_670;
      outport: OutputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => false)
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
    end Block; -- outport group 3
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
  signal memory_space_1_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_1_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_1_sr_addr : std_logic_vector(3 downto 0);
  signal memory_space_1_sr_data : std_logic_vector(7 downto 0);
  signal memory_space_1_sr_tag : std_logic_vector(0 downto 0);
  signal memory_space_1_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_1_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_1_sc_tag :  std_logic_vector(0 downto 0);
  -- interface signals to connect to memory space memory_space_10
  -- interface signals to connect to memory space memory_space_11
  -- interface signals to connect to memory space memory_space_12
  -- interface signals to connect to memory space memory_space_13
  -- interface signals to connect to memory space memory_space_14
  -- interface signals to connect to memory space memory_space_15
  -- interface signals to connect to memory space memory_space_16
  -- interface signals to connect to memory space memory_space_2
  signal memory_space_2_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_2_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_2_lr_addr : std_logic_vector(2 downto 0);
  signal memory_space_2_lr_tag : std_logic_vector(2 downto 0);
  signal memory_space_2_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_2_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_2_lc_data : std_logic_vector(7 downto 0);
  signal memory_space_2_lc_tag :  std_logic_vector(2 downto 0);
  signal memory_space_2_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_2_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_2_sr_addr : std_logic_vector(2 downto 0);
  signal memory_space_2_sr_data : std_logic_vector(7 downto 0);
  signal memory_space_2_sr_tag : std_logic_vector(2 downto 0);
  signal memory_space_2_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_2_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_2_sc_tag :  std_logic_vector(2 downto 0);
  -- interface signals to connect to memory space memory_space_3
  signal memory_space_3_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_3_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_3_lr_addr : std_logic_vector(10 downto 0);
  signal memory_space_3_lr_tag : std_logic_vector(1 downto 0);
  signal memory_space_3_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_3_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_3_lc_data : std_logic_vector(63 downto 0);
  signal memory_space_3_lc_tag :  std_logic_vector(1 downto 0);
  signal memory_space_3_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_3_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_3_sr_addr : std_logic_vector(10 downto 0);
  signal memory_space_3_sr_data : std_logic_vector(63 downto 0);
  signal memory_space_3_sr_tag : std_logic_vector(1 downto 0);
  signal memory_space_3_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_3_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_3_sc_tag :  std_logic_vector(1 downto 0);
  -- interface signals to connect to memory space memory_space_4
  -- interface signals to connect to memory space memory_space_5
  -- interface signals to connect to memory space memory_space_6
  -- interface signals to connect to memory space memory_space_7
  -- interface signals to connect to memory space memory_space_8
  -- interface signals to connect to memory space memory_space_9
  -- declarations related to module free_queue_manager
  component free_queue_manager is -- 
    generic (tag_length : integer); 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic;
      memory_space_2_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_2_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_lr_addr : out  std_logic_vector(2 downto 0);
      memory_space_2_lr_tag :  out  std_logic_vector(2 downto 0);
      memory_space_2_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_2_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_lc_data : in   std_logic_vector(7 downto 0);
      memory_space_2_lc_tag :  in  std_logic_vector(2 downto 0);
      memory_space_2_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_2_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_sr_addr : out  std_logic_vector(2 downto 0);
      memory_space_2_sr_data : out  std_logic_vector(7 downto 0);
      memory_space_2_sr_tag :  out  std_logic_vector(2 downto 0);
      memory_space_2_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_2_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_sc_tag :  in  std_logic_vector(2 downto 0);
      free_queue_request_pipe_read_req : out  std_logic_vector(0 downto 0);
      free_queue_request_pipe_read_ack : in   std_logic_vector(0 downto 0);
      free_queue_request_pipe_read_data : in   std_logic_vector(7 downto 0);
      free_queue_put_pipe_read_req : out  std_logic_vector(0 downto 0);
      free_queue_put_pipe_read_ack : in   std_logic_vector(0 downto 0);
      free_queue_put_pipe_read_data : in   std_logic_vector(31 downto 0);
      free_queue_ack_pipe_write_req : out  std_logic_vector(0 downto 0);
      free_queue_ack_pipe_write_ack : in   std_logic_vector(0 downto 0);
      free_queue_ack_pipe_write_data : out  std_logic_vector(7 downto 0);
      free_queue_get_pipe_write_req : out  std_logic_vector(0 downto 0);
      free_queue_get_pipe_write_ack : in   std_logic_vector(0 downto 0);
      free_queue_get_pipe_write_data : out  std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
    -- 
  end component;
  -- argument signals for module free_queue_manager
  signal free_queue_manager_tag_in    : std_logic_vector(0 downto 0) := (others => '0');
  signal free_queue_manager_tag_out   : std_logic_vector(0 downto 0);
  signal free_queue_manager_start_req : std_logic;
  signal free_queue_manager_start_ack : std_logic;
  signal free_queue_manager_fin_req   : std_logic;
  signal free_queue_manager_fin_ack : std_logic;
  -- declarations related to module output_port_lookup
  component output_port_lookup is -- 
    generic (tag_length : integer); 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic;
      op_lut_ctrl_pipe_read_req : out  std_logic_vector(0 downto 0);
      op_lut_ctrl_pipe_read_ack : in   std_logic_vector(0 downto 0);
      op_lut_ctrl_pipe_read_data : in   std_logic_vector(7 downto 0);
      op_lut_data_pipe_read_req : out  std_logic_vector(0 downto 0);
      op_lut_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
      op_lut_data_pipe_read_data : in   std_logic_vector(63 downto 0);
      out_ctrl_pipe_write_req : out  std_logic_vector(0 downto 0);
      out_ctrl_pipe_write_ack : in   std_logic_vector(0 downto 0);
      out_ctrl_pipe_write_data : out  std_logic_vector(7 downto 0);
      out_data_pipe_write_req : out  std_logic_vector(0 downto 0);
      out_data_pipe_write_ack : in   std_logic_vector(0 downto 0);
      out_data_pipe_write_data : out  std_logic_vector(63 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
    -- 
  end component;
  -- argument signals for module output_port_lookup
  signal output_port_lookup_tag_in    : std_logic_vector(0 downto 0) := (others => '0');
  signal output_port_lookup_tag_out   : std_logic_vector(0 downto 0);
  signal output_port_lookup_start_req : std_logic;
  signal output_port_lookup_start_ack : std_logic;
  signal output_port_lookup_fin_req   : std_logic;
  signal output_port_lookup_fin_ack : std_logic;
  -- declarations related to module wrapper_input
  component wrapper_input is -- 
    generic (tag_length : integer); 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic;
      memory_space_3_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_3_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_3_sr_addr : out  std_logic_vector(10 downto 0);
      memory_space_3_sr_data : out  std_logic_vector(63 downto 0);
      memory_space_3_sr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_3_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_3_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_3_sc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_1_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_1_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_sr_addr : out  std_logic_vector(3 downto 0);
      memory_space_1_sr_data : out  std_logic_vector(7 downto 0);
      memory_space_1_sr_tag :  out  std_logic_vector(0 downto 0);
      memory_space_1_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_1_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_sc_tag :  in  std_logic_vector(0 downto 0);
      free_queue_ack_pipe_read_req : out  std_logic_vector(0 downto 0);
      free_queue_ack_pipe_read_ack : in   std_logic_vector(0 downto 0);
      free_queue_ack_pipe_read_data : in   std_logic_vector(7 downto 0);
      free_queue_get_pipe_read_req : out  std_logic_vector(0 downto 0);
      free_queue_get_pipe_read_ack : in   std_logic_vector(0 downto 0);
      free_queue_get_pipe_read_data : in   std_logic_vector(31 downto 0);
      in_ctrl_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_ctrl_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_ctrl_pipe_read_data : in   std_logic_vector(7 downto 0);
      in_data_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_data_pipe_read_data : in   std_logic_vector(63 downto 0);
      free_queue_request_pipe_write_req : out  std_logic_vector(0 downto 0);
      free_queue_request_pipe_write_ack : in   std_logic_vector(0 downto 0);
      free_queue_request_pipe_write_data : out  std_logic_vector(7 downto 0);
      midpipe_pipe_write_req : out  std_logic_vector(0 downto 0);
      midpipe_pipe_write_ack : in   std_logic_vector(0 downto 0);
      midpipe_pipe_write_data : out  std_logic_vector(31 downto 0);
      last_ctrl_pipe_write_req : out  std_logic_vector(0 downto 0);
      last_ctrl_pipe_write_ack : in   std_logic_vector(0 downto 0);
      last_ctrl_pipe_write_data : out  std_logic_vector(7 downto 0);
      pkt_length_pipe_write_req : out  std_logic_vector(0 downto 0);
      pkt_length_pipe_write_ack : in   std_logic_vector(0 downto 0);
      pkt_length_pipe_write_data : out  std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
    -- 
  end component;
  -- argument signals for module wrapper_input
  signal wrapper_input_tag_in    : std_logic_vector(0 downto 0) := (others => '0');
  signal wrapper_input_tag_out   : std_logic_vector(0 downto 0);
  signal wrapper_input_start_req : std_logic;
  signal wrapper_input_start_ack : std_logic;
  signal wrapper_input_fin_req   : std_logic;
  signal wrapper_input_fin_ack : std_logic;
  -- declarations related to module wrapper_output
  component wrapper_output is -- 
    generic (tag_length : integer); 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic;
      memory_space_3_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_3_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_3_lr_addr : out  std_logic_vector(10 downto 0);
      memory_space_3_lr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_3_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_3_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_3_lc_data : in   std_logic_vector(63 downto 0);
      memory_space_3_lc_tag :  in  std_logic_vector(1 downto 0);
      midpipe_pipe_read_req : out  std_logic_vector(0 downto 0);
      midpipe_pipe_read_ack : in   std_logic_vector(0 downto 0);
      midpipe_pipe_read_data : in   std_logic_vector(31 downto 0);
      last_ctrl_pipe_read_req : out  std_logic_vector(0 downto 0);
      last_ctrl_pipe_read_ack : in   std_logic_vector(0 downto 0);
      last_ctrl_pipe_read_data : in   std_logic_vector(7 downto 0);
      pkt_length_pipe_read_req : out  std_logic_vector(0 downto 0);
      pkt_length_pipe_read_ack : in   std_logic_vector(0 downto 0);
      pkt_length_pipe_read_data : in   std_logic_vector(31 downto 0);
      free_queue_request_pipe_write_req : out  std_logic_vector(0 downto 0);
      free_queue_request_pipe_write_ack : in   std_logic_vector(0 downto 0);
      free_queue_request_pipe_write_data : out  std_logic_vector(7 downto 0);
      free_queue_put_pipe_write_req : out  std_logic_vector(0 downto 0);
      free_queue_put_pipe_write_ack : in   std_logic_vector(0 downto 0);
      free_queue_put_pipe_write_data : out  std_logic_vector(31 downto 0);
      op_lut_ctrl_pipe_write_req : out  std_logic_vector(0 downto 0);
      op_lut_ctrl_pipe_write_ack : in   std_logic_vector(0 downto 0);
      op_lut_ctrl_pipe_write_data : out  std_logic_vector(7 downto 0);
      op_lut_data_pipe_write_req : out  std_logic_vector(0 downto 0);
      op_lut_data_pipe_write_ack : in   std_logic_vector(0 downto 0);
      op_lut_data_pipe_write_data : out  std_logic_vector(63 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
    -- 
  end component;
  -- argument signals for module wrapper_output
  signal wrapper_output_tag_in    : std_logic_vector(0 downto 0) := (others => '0');
  signal wrapper_output_tag_out   : std_logic_vector(0 downto 0);
  signal wrapper_output_start_req : std_logic;
  signal wrapper_output_start_ack : std_logic;
  signal wrapper_output_fin_req   : std_logic;
  signal wrapper_output_fin_ack : std_logic;
  -- aggregate signals for write to pipe free_queue_ack
  signal free_queue_ack_pipe_write_data: std_logic_vector(7 downto 0);
  signal free_queue_ack_pipe_write_req: std_logic_vector(0 downto 0);
  signal free_queue_ack_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe free_queue_ack
  signal free_queue_ack_pipe_read_data: std_logic_vector(7 downto 0);
  signal free_queue_ack_pipe_read_req: std_logic_vector(0 downto 0);
  signal free_queue_ack_pipe_read_ack: std_logic_vector(0 downto 0);
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
  -- aggregate signals for read from pipe in_ctrl
  signal in_ctrl_pipe_read_data: std_logic_vector(7 downto 0);
  signal in_ctrl_pipe_read_req: std_logic_vector(0 downto 0);
  signal in_ctrl_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe in_data
  signal in_data_pipe_read_data: std_logic_vector(63 downto 0);
  signal in_data_pipe_read_req: std_logic_vector(0 downto 0);
  signal in_data_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe last_ctrl
  signal last_ctrl_pipe_write_data: std_logic_vector(7 downto 0);
  signal last_ctrl_pipe_write_req: std_logic_vector(0 downto 0);
  signal last_ctrl_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe last_ctrl
  signal last_ctrl_pipe_read_data: std_logic_vector(7 downto 0);
  signal last_ctrl_pipe_read_req: std_logic_vector(0 downto 0);
  signal last_ctrl_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe midpipe
  signal midpipe_pipe_write_data: std_logic_vector(31 downto 0);
  signal midpipe_pipe_write_req: std_logic_vector(0 downto 0);
  signal midpipe_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe midpipe
  signal midpipe_pipe_read_data: std_logic_vector(31 downto 0);
  signal midpipe_pipe_read_req: std_logic_vector(0 downto 0);
  signal midpipe_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe op_lut_ctrl
  signal op_lut_ctrl_pipe_write_data: std_logic_vector(7 downto 0);
  signal op_lut_ctrl_pipe_write_req: std_logic_vector(0 downto 0);
  signal op_lut_ctrl_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe op_lut_ctrl
  signal op_lut_ctrl_pipe_read_data: std_logic_vector(7 downto 0);
  signal op_lut_ctrl_pipe_read_req: std_logic_vector(0 downto 0);
  signal op_lut_ctrl_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe op_lut_data
  signal op_lut_data_pipe_write_data: std_logic_vector(63 downto 0);
  signal op_lut_data_pipe_write_req: std_logic_vector(0 downto 0);
  signal op_lut_data_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe op_lut_data
  signal op_lut_data_pipe_read_data: std_logic_vector(63 downto 0);
  signal op_lut_data_pipe_read_req: std_logic_vector(0 downto 0);
  signal op_lut_data_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe out_ctrl
  signal out_ctrl_pipe_write_data: std_logic_vector(7 downto 0);
  signal out_ctrl_pipe_write_req: std_logic_vector(0 downto 0);
  signal out_ctrl_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe out_data
  signal out_data_pipe_write_data: std_logic_vector(63 downto 0);
  signal out_data_pipe_write_req: std_logic_vector(0 downto 0);
  signal out_data_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe pkt_length
  signal pkt_length_pipe_write_data: std_logic_vector(31 downto 0);
  signal pkt_length_pipe_write_req: std_logic_vector(0 downto 0);
  signal pkt_length_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe pkt_length
  signal pkt_length_pipe_read_data: std_logic_vector(31 downto 0);
  signal pkt_length_pipe_read_req: std_logic_vector(0 downto 0);
  signal pkt_length_pipe_read_ack: std_logic_vector(0 downto 0);
  -- 
begin -- 
  -- module free_queue_manager
  free_queue_manager_instance:free_queue_manager-- 
    generic map(tag_length => 1)
    port map(-- 
      start_req => free_queue_manager_start_req,
      start_ack => free_queue_manager_start_ack,
      fin_req => free_queue_manager_fin_req,
      fin_ack => free_queue_manager_fin_ack,
      clk => clk,
      reset => reset,
      memory_space_2_lr_req => memory_space_2_lr_req(0 downto 0),
      memory_space_2_lr_ack => memory_space_2_lr_ack(0 downto 0),
      memory_space_2_lr_addr => memory_space_2_lr_addr(2 downto 0),
      memory_space_2_lr_tag => memory_space_2_lr_tag(2 downto 0),
      memory_space_2_lc_req => memory_space_2_lc_req(0 downto 0),
      memory_space_2_lc_ack => memory_space_2_lc_ack(0 downto 0),
      memory_space_2_lc_data => memory_space_2_lc_data(7 downto 0),
      memory_space_2_lc_tag => memory_space_2_lc_tag(2 downto 0),
      memory_space_2_sr_req => memory_space_2_sr_req(0 downto 0),
      memory_space_2_sr_ack => memory_space_2_sr_ack(0 downto 0),
      memory_space_2_sr_addr => memory_space_2_sr_addr(2 downto 0),
      memory_space_2_sr_data => memory_space_2_sr_data(7 downto 0),
      memory_space_2_sr_tag => memory_space_2_sr_tag(2 downto 0),
      memory_space_2_sc_req => memory_space_2_sc_req(0 downto 0),
      memory_space_2_sc_ack => memory_space_2_sc_ack(0 downto 0),
      memory_space_2_sc_tag => memory_space_2_sc_tag(2 downto 0),
      free_queue_request_pipe_read_req => free_queue_request_pipe_read_req(0 downto 0),
      free_queue_request_pipe_read_ack => free_queue_request_pipe_read_ack(0 downto 0),
      free_queue_request_pipe_read_data => free_queue_request_pipe_read_data(7 downto 0),
      free_queue_put_pipe_read_req => free_queue_put_pipe_read_req(0 downto 0),
      free_queue_put_pipe_read_ack => free_queue_put_pipe_read_ack(0 downto 0),
      free_queue_put_pipe_read_data => free_queue_put_pipe_read_data(31 downto 0),
      free_queue_ack_pipe_write_req => free_queue_ack_pipe_write_req(0 downto 0),
      free_queue_ack_pipe_write_ack => free_queue_ack_pipe_write_ack(0 downto 0),
      free_queue_ack_pipe_write_data => free_queue_ack_pipe_write_data(7 downto 0),
      free_queue_get_pipe_write_req => free_queue_get_pipe_write_req(0 downto 0),
      free_queue_get_pipe_write_ack => free_queue_get_pipe_write_ack(0 downto 0),
      free_queue_get_pipe_write_data => free_queue_get_pipe_write_data(31 downto 0),
      tag_in => free_queue_manager_tag_in,
      tag_out => free_queue_manager_tag_out-- 
    ); -- 
  -- module will be run forever 
  free_queue_manager_tag_in <= (others => '0');
  free_queue_manager_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => free_queue_manager_start_req, start_ack => free_queue_manager_start_ack,  fin_req => free_queue_manager_fin_req,  fin_ack => free_queue_manager_fin_ack);
  -- module output_port_lookup
  output_port_lookup_instance:output_port_lookup-- 
    generic map(tag_length => 1)
    port map(-- 
      start_req => output_port_lookup_start_req,
      start_ack => output_port_lookup_start_ack,
      fin_req => output_port_lookup_fin_req,
      fin_ack => output_port_lookup_fin_ack,
      clk => clk,
      reset => reset,
      op_lut_ctrl_pipe_read_req => op_lut_ctrl_pipe_read_req(0 downto 0),
      op_lut_ctrl_pipe_read_ack => op_lut_ctrl_pipe_read_ack(0 downto 0),
      op_lut_ctrl_pipe_read_data => op_lut_ctrl_pipe_read_data(7 downto 0),
      op_lut_data_pipe_read_req => op_lut_data_pipe_read_req(0 downto 0),
      op_lut_data_pipe_read_ack => op_lut_data_pipe_read_ack(0 downto 0),
      op_lut_data_pipe_read_data => op_lut_data_pipe_read_data(63 downto 0),
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
  output_port_lookup_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => output_port_lookup_start_req, start_ack => output_port_lookup_start_ack,  fin_req => output_port_lookup_fin_req,  fin_ack => output_port_lookup_fin_ack);
  -- module wrapper_input
  wrapper_input_instance:wrapper_input-- 
    generic map(tag_length => 1)
    port map(-- 
      start_req => wrapper_input_start_req,
      start_ack => wrapper_input_start_ack,
      fin_req => wrapper_input_fin_req,
      fin_ack => wrapper_input_fin_ack,
      clk => clk,
      reset => reset,
      memory_space_1_sr_req => memory_space_1_sr_req(0 downto 0),
      memory_space_1_sr_ack => memory_space_1_sr_ack(0 downto 0),
      memory_space_1_sr_addr => memory_space_1_sr_addr(3 downto 0),
      memory_space_1_sr_data => memory_space_1_sr_data(7 downto 0),
      memory_space_1_sr_tag => memory_space_1_sr_tag(0 downto 0),
      memory_space_1_sc_req => memory_space_1_sc_req(0 downto 0),
      memory_space_1_sc_ack => memory_space_1_sc_ack(0 downto 0),
      memory_space_1_sc_tag => memory_space_1_sc_tag(0 downto 0),
      memory_space_3_sr_req => memory_space_3_sr_req(0 downto 0),
      memory_space_3_sr_ack => memory_space_3_sr_ack(0 downto 0),
      memory_space_3_sr_addr => memory_space_3_sr_addr(10 downto 0),
      memory_space_3_sr_data => memory_space_3_sr_data(63 downto 0),
      memory_space_3_sr_tag => memory_space_3_sr_tag(1 downto 0),
      memory_space_3_sc_req => memory_space_3_sc_req(0 downto 0),
      memory_space_3_sc_ack => memory_space_3_sc_ack(0 downto 0),
      memory_space_3_sc_tag => memory_space_3_sc_tag(1 downto 0),
      free_queue_ack_pipe_read_req => free_queue_ack_pipe_read_req(0 downto 0),
      free_queue_ack_pipe_read_ack => free_queue_ack_pipe_read_ack(0 downto 0),
      free_queue_ack_pipe_read_data => free_queue_ack_pipe_read_data(7 downto 0),
      free_queue_get_pipe_read_req => free_queue_get_pipe_read_req(0 downto 0),
      free_queue_get_pipe_read_ack => free_queue_get_pipe_read_ack(0 downto 0),
      free_queue_get_pipe_read_data => free_queue_get_pipe_read_data(31 downto 0),
      in_ctrl_pipe_read_req => in_ctrl_pipe_read_req(0 downto 0),
      in_ctrl_pipe_read_ack => in_ctrl_pipe_read_ack(0 downto 0),
      in_ctrl_pipe_read_data => in_ctrl_pipe_read_data(7 downto 0),
      in_data_pipe_read_req => in_data_pipe_read_req(0 downto 0),
      in_data_pipe_read_ack => in_data_pipe_read_ack(0 downto 0),
      in_data_pipe_read_data => in_data_pipe_read_data(63 downto 0),
      free_queue_request_pipe_write_req => free_queue_request_pipe_write_req(0 downto 0),
      free_queue_request_pipe_write_ack => free_queue_request_pipe_write_ack(0 downto 0),
      free_queue_request_pipe_write_data => free_queue_request_pipe_write_data(7 downto 0),
      midpipe_pipe_write_req => midpipe_pipe_write_req(0 downto 0),
      midpipe_pipe_write_ack => midpipe_pipe_write_ack(0 downto 0),
      midpipe_pipe_write_data => midpipe_pipe_write_data(31 downto 0),
      last_ctrl_pipe_write_req => last_ctrl_pipe_write_req(0 downto 0),
      last_ctrl_pipe_write_ack => last_ctrl_pipe_write_ack(0 downto 0),
      last_ctrl_pipe_write_data => last_ctrl_pipe_write_data(7 downto 0),
      pkt_length_pipe_write_req => pkt_length_pipe_write_req(0 downto 0),
      pkt_length_pipe_write_ack => pkt_length_pipe_write_ack(0 downto 0),
      pkt_length_pipe_write_data => pkt_length_pipe_write_data(31 downto 0),
      tag_in => wrapper_input_tag_in,
      tag_out => wrapper_input_tag_out-- 
    ); -- 
  -- module will be run forever 
  wrapper_input_tag_in <= (others => '0');
  wrapper_input_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => wrapper_input_start_req, start_ack => wrapper_input_start_ack,  fin_req => wrapper_input_fin_req,  fin_ack => wrapper_input_fin_ack);
  -- module wrapper_output
  wrapper_output_instance:wrapper_output-- 
    generic map(tag_length => 1)
    port map(-- 
      start_req => wrapper_output_start_req,
      start_ack => wrapper_output_start_ack,
      fin_req => wrapper_output_fin_req,
      fin_ack => wrapper_output_fin_ack,
      clk => clk,
      reset => reset,
      memory_space_3_lr_req => memory_space_3_lr_req(0 downto 0),
      memory_space_3_lr_ack => memory_space_3_lr_ack(0 downto 0),
      memory_space_3_lr_addr => memory_space_3_lr_addr(10 downto 0),
      memory_space_3_lr_tag => memory_space_3_lr_tag(1 downto 0),
      memory_space_3_lc_req => memory_space_3_lc_req(0 downto 0),
      memory_space_3_lc_ack => memory_space_3_lc_ack(0 downto 0),
      memory_space_3_lc_data => memory_space_3_lc_data(63 downto 0),
      memory_space_3_lc_tag => memory_space_3_lc_tag(1 downto 0),
      midpipe_pipe_read_req => midpipe_pipe_read_req(0 downto 0),
      midpipe_pipe_read_ack => midpipe_pipe_read_ack(0 downto 0),
      midpipe_pipe_read_data => midpipe_pipe_read_data(31 downto 0),
      last_ctrl_pipe_read_req => last_ctrl_pipe_read_req(0 downto 0),
      last_ctrl_pipe_read_ack => last_ctrl_pipe_read_ack(0 downto 0),
      last_ctrl_pipe_read_data => last_ctrl_pipe_read_data(7 downto 0),
      pkt_length_pipe_read_req => pkt_length_pipe_read_req(0 downto 0),
      pkt_length_pipe_read_ack => pkt_length_pipe_read_ack(0 downto 0),
      pkt_length_pipe_read_data => pkt_length_pipe_read_data(31 downto 0),
      free_queue_request_pipe_write_req => free_queue_request_pipe_write_req(1 downto 1),
      free_queue_request_pipe_write_ack => free_queue_request_pipe_write_ack(1 downto 1),
      free_queue_request_pipe_write_data => free_queue_request_pipe_write_data(15 downto 8),
      free_queue_put_pipe_write_req => free_queue_put_pipe_write_req(0 downto 0),
      free_queue_put_pipe_write_ack => free_queue_put_pipe_write_ack(0 downto 0),
      free_queue_put_pipe_write_data => free_queue_put_pipe_write_data(31 downto 0),
      op_lut_ctrl_pipe_write_req => op_lut_ctrl_pipe_write_req(0 downto 0),
      op_lut_ctrl_pipe_write_ack => op_lut_ctrl_pipe_write_ack(0 downto 0),
      op_lut_ctrl_pipe_write_data => op_lut_ctrl_pipe_write_data(7 downto 0),
      op_lut_data_pipe_write_req => op_lut_data_pipe_write_req(0 downto 0),
      op_lut_data_pipe_write_ack => op_lut_data_pipe_write_ack(0 downto 0),
      op_lut_data_pipe_write_data => op_lut_data_pipe_write_data(63 downto 0),
      tag_in => wrapper_output_tag_in,
      tag_out => wrapper_output_tag_out-- 
    ); -- 
  -- module will be run forever 
  wrapper_output_tag_in <= (others => '0');
  wrapper_output_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => wrapper_output_start_req, start_ack => wrapper_output_start_ack,  fin_req => wrapper_output_fin_req,  fin_ack => wrapper_output_fin_ack);
  free_queue_ack_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 8,
      depth => 1 --
    )
    port map( -- 
      read_req => free_queue_ack_pipe_read_req,
      read_ack => free_queue_ack_pipe_read_ack,
      read_data => free_queue_ack_pipe_read_data,
      write_req => free_queue_ack_pipe_write_req,
      write_ack => free_queue_ack_pipe_write_ack,
      write_data => free_queue_ack_pipe_write_data,
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
  last_ctrl_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 8,
      depth => 1 --
    )
    port map( -- 
      read_req => last_ctrl_pipe_read_req,
      read_ack => last_ctrl_pipe_read_ack,
      read_data => last_ctrl_pipe_read_data,
      write_req => last_ctrl_pipe_write_req,
      write_ack => last_ctrl_pipe_write_ack,
      write_data => last_ctrl_pipe_write_data,
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
  op_lut_ctrl_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 8,
      depth => 1 --
    )
    port map( -- 
      read_req => op_lut_ctrl_pipe_read_req,
      read_ack => op_lut_ctrl_pipe_read_ack,
      read_data => op_lut_ctrl_pipe_read_data,
      write_req => op_lut_ctrl_pipe_write_req,
      write_ack => op_lut_ctrl_pipe_write_ack,
      write_data => op_lut_ctrl_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  op_lut_data_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 64,
      depth => 1 --
    )
    port map( -- 
      read_req => op_lut_data_pipe_read_req,
      read_ack => op_lut_data_pipe_read_ack,
      read_data => op_lut_data_pipe_read_data,
      write_req => op_lut_data_pipe_write_req,
      write_ack => op_lut_data_pipe_write_ack,
      write_data => op_lut_data_pipe_write_data,
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
  pkt_length_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      depth => 1 --
    )
    port map( -- 
      read_req => pkt_length_pipe_read_req,
      read_ack => pkt_length_pipe_read_ack,
      read_data => pkt_length_pipe_read_data,
      write_req => pkt_length_pipe_write_req,
      write_ack => pkt_length_pipe_write_ack,
      write_data => pkt_length_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  dummyWOM_memory_space_1: dummy_write_only_memory_subsystem -- 
    generic map(-- 
      num_stores => 1,
      addr_width => 4,
      data_width => 8,
      tag_width => 1
      ) -- 
    port map(-- 
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
      addr_width => 3,
      data_width => 8,
      tag_width => 3,
      num_registers => 4) -- 
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
  MemorySpace_memory_space_3: memory_subsystem -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 11,
      data_width => 64,
      tag_width => 2,
      number_of_banks => 1,
      mux_degree => 2,
      demux_degree => 2,
      base_bank_addr_width => 11,
      base_bank_data_width => 64
      ) -- 
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
