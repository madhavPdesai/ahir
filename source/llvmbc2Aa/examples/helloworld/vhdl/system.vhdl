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
    signal cp_elements: BooleanArray(97 downto 0);
    -- 
  begin -- 
    cp_elements(0) <= true when start = '1' else false;
    fin <= '1' when cp_elements(97) else '0';
    cp_elements(1) <= cp_elements(0);
    cp_elements(2) <= cp_elements(20);
    cp_elements(3) <= cp_elements(23);
    cp_elements(4) <= cp_elements(41);
    cp_elements(5) <= cp_elements(44);
    cp_elements(6) <= OrReduce(cp_elements(86) & cp_elements(83));
    cp_elements(7) <= cp_elements(59);
    cp_elements(8) <= cp_elements(89);
    cp_elements(9) <= cp_elements(66);
    cp_elements(10) <= cp_elements(93);
    cp_elements(11) <= cp_elements(76);
    cp_elements(12) <= cp_elements(96);
    cp_elements(13) <= cp_elements(80);
    cp_elements(14) <= cp_elements(1);
    cp_elements(15) <= cp_elements(14);
    cpelement_group_16 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(17) & cp_elements(15));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(16),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_138_gather_scatter_req_0 <= cp_elements(16);
    cp_elements(17) <= cp_elements(14);
    cp_elements(18) <= simple_obj_ref_138_gather_scatter_ack_0;
    simple_obj_ref_138_store_0_req_0 <= cp_elements(18);
    cp_elements(19) <= simple_obj_ref_138_store_0_ack_0;
    simple_obj_ref_138_store_0_req_1 <= cp_elements(19);
    cp_elements(20) <= simple_obj_ref_138_store_0_ack_1;
    cp_elements(21) <= cp_elements(2);
    call_stmt_144_call_req_0 <= cp_elements(21);
    cp_elements(22) <= call_stmt_144_call_ack_0;
    call_stmt_144_call_req_1 <= cp_elements(22);
    cp_elements(23) <= call_stmt_144_call_ack_1;
    cp_elements(24) <= cp_elements(3);
    cp_elements(25) <= cp_elements(24);
    cpelement_group_26 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(25) & cp_elements(27));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(26),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_145_gather_scatter_req_0 <= cp_elements(26);
    cp_elements(27) <= cp_elements(24);
    cp_elements(28) <= simple_obj_ref_145_gather_scatter_ack_0;
    simple_obj_ref_145_store_0_req_0 <= cp_elements(28);
    cp_elements(29) <= simple_obj_ref_145_store_0_ack_0;
    cp_elements(30) <= cp_elements(29);
    simple_obj_ref_145_store_0_req_1 <= cp_elements(30);
    cp_elements(31) <= simple_obj_ref_145_store_0_ack_1;
    cpelement_group_32 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(33) & cp_elements(29));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(32),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_149_load_0_req_0 <= cp_elements(32);
    cp_elements(33) <= cp_elements(24);
    cp_elements(34) <= simple_obj_ref_149_load_0_ack_0;
    simple_obj_ref_149_load_0_req_1 <= cp_elements(34);
    cp_elements(35) <= simple_obj_ref_149_load_0_ack_1;
    simple_obj_ref_149_gather_scatter_req_0 <= cp_elements(35);
    cp_elements(36) <= simple_obj_ref_149_gather_scatter_ack_0;
    cpelement_group_37 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(38) & cp_elements(36));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(37),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_154_inst_req_0 <= cp_elements(37);
    cp_elements(38) <= cp_elements(24);
    cp_elements(39) <= binary_154_inst_ack_0;
    binary_154_inst_req_1 <= cp_elements(39);
    cp_elements(40) <= binary_154_inst_ack_1;
    cpelement_group_41 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(40) & cp_elements(31));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(41),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(42) <= cp_elements(4);
    cp_elements(43) <= cp_elements(42);
    cp_elements(44) <= cp_elements(43);
    cp_elements(45) <= cp_elements(4);
    if_stmt_157_branch_req_0 <= cp_elements(45);
    cp_elements(46) <= cp_elements(45);
    cp_elements(47) <= cp_elements(46);
    cp_elements(48) <= if_stmt_157_branch_ack_1;
    cp_elements(49) <= cp_elements(46);
    cp_elements(50) <= if_stmt_157_branch_ack_0;
    cp_elements(51) <= cp_elements(48);
    cp_elements(52) <= cp_elements(50);
    cp_elements(53) <= cp_elements(6);
    cp_elements(54) <= cp_elements(53);
    cpelement_group_55 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(56) & cp_elements(54));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(55),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_164_gather_scatter_req_0 <= cp_elements(55);
    cp_elements(56) <= cp_elements(53);
    cp_elements(57) <= simple_obj_ref_164_gather_scatter_ack_0;
    simple_obj_ref_164_store_0_req_0 <= cp_elements(57);
    cp_elements(58) <= simple_obj_ref_164_store_0_ack_0;
    simple_obj_ref_164_store_0_req_1 <= cp_elements(58);
    cp_elements(59) <= simple_obj_ref_164_store_0_ack_1;
    cp_elements(60) <= cp_elements(8);
    cp_elements(61) <= cp_elements(60);
    cpelement_group_62 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(61) & cp_elements(63));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(62),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_169_gather_scatter_req_0 <= cp_elements(62);
    cp_elements(63) <= cp_elements(60);
    cp_elements(64) <= simple_obj_ref_169_gather_scatter_ack_0;
    simple_obj_ref_169_store_0_req_0 <= cp_elements(64);
    cp_elements(65) <= simple_obj_ref_169_store_0_ack_0;
    simple_obj_ref_169_store_0_req_1 <= cp_elements(65);
    cp_elements(66) <= simple_obj_ref_169_store_0_ack_1;
    cp_elements(67) <= cp_elements(10);
    cp_elements(68) <= cp_elements(67);
    simple_obj_ref_175_load_0_req_0 <= cp_elements(68);
    cp_elements(69) <= simple_obj_ref_175_load_0_ack_0;
    simple_obj_ref_175_load_0_req_1 <= cp_elements(69);
    cp_elements(70) <= simple_obj_ref_175_load_0_ack_1;
    simple_obj_ref_175_gather_scatter_req_0 <= cp_elements(70);
    cp_elements(71) <= simple_obj_ref_175_gather_scatter_ack_0;
    cpelement_group_72 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(71) & cp_elements(73));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(72),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_177_gather_scatter_req_0 <= cp_elements(72);
    cp_elements(73) <= cp_elements(67);
    cp_elements(74) <= simple_obj_ref_177_gather_scatter_ack_0;
    simple_obj_ref_177_store_0_req_0 <= cp_elements(74);
    cp_elements(75) <= simple_obj_ref_177_store_0_ack_0;
    simple_obj_ref_177_store_0_req_1 <= cp_elements(75);
    cp_elements(76) <= simple_obj_ref_177_store_0_ack_1;
    cp_elements(77) <= cp_elements(12);
    simple_obj_ref_183_load_0_req_0 <= cp_elements(77);
    cp_elements(78) <= simple_obj_ref_183_load_0_ack_0;
    simple_obj_ref_183_load_0_req_1 <= cp_elements(78);
    cp_elements(79) <= simple_obj_ref_183_load_0_ack_1;
    simple_obj_ref_183_gather_scatter_req_0 <= cp_elements(79);
    cp_elements(80) <= simple_obj_ref_183_gather_scatter_ack_0;
    cp_elements(81) <= cp_elements(5);
    cp_elements(82) <= cp_elements(81);
    cp_elements(83) <= cp_elements(82);
    cp_elements(84) <= cp_elements(51);
    cp_elements(85) <= cp_elements(84);
    cp_elements(86) <= cp_elements(85);
    cp_elements(87) <= cp_elements(52);
    cp_elements(88) <= cp_elements(87);
    cp_elements(89) <= cp_elements(88);
    cp_elements(90) <= cp_elements(7);
    cp_elements(91) <= cp_elements(9);
    cp_elements(92) <= OrReduce(cp_elements(90) & cp_elements(91));
    cp_elements(93) <= cp_elements(92);
    cp_elements(94) <= cp_elements(11);
    cp_elements(95) <= cp_elements(94);
    cp_elements(96) <= cp_elements(95);
    cp_elements(97) <= cp_elements(13);
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
    signal cp_elements: BooleanArray(89 downto 0);
    -- 
  begin -- 
    cp_elements(0) <= true when start = '1' else false;
    fin <= '1' when cp_elements(89) else '0';
    cp_elements(1) <= cp_elements(0);
    cp_elements(2) <= cp_elements(68);
    cp_elements(3) <= cp_elements(74);
    cp_elements(4) <= cp_elements(81);
    cp_elements(5) <= cp_elements(88);
    cp_elements(6) <= cp_elements(85);
    cp_elements(7) <= cp_elements(1);
    cp_elements(8) <= cp_elements(7);
    cpelement_group_9 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(8) & cp_elements(10));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(9),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_61_gather_scatter_req_0 <= cp_elements(9);
    cp_elements(10) <= cp_elements(7);
    cp_elements(11) <= simple_obj_ref_61_gather_scatter_ack_0;
    simple_obj_ref_61_store_0_req_0 <= cp_elements(11);
    cp_elements(12) <= simple_obj_ref_61_store_0_ack_0;
    cp_elements(13) <= cp_elements(12);
    simple_obj_ref_61_store_0_req_1 <= cp_elements(13);
    cp_elements(14) <= simple_obj_ref_61_store_0_ack_1;
    cp_elements(15) <= cp_elements(7);
    cpelement_group_16 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(15) & cp_elements(17));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(16),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_64_gather_scatter_req_0 <= cp_elements(16);
    cp_elements(17) <= cp_elements(7);
    cp_elements(18) <= simple_obj_ref_64_gather_scatter_ack_0;
    simple_obj_ref_64_store_0_req_0 <= cp_elements(18);
    cp_elements(19) <= simple_obj_ref_64_store_0_ack_0;
    cp_elements(20) <= cp_elements(19);
    simple_obj_ref_64_store_0_req_1 <= cp_elements(20);
    cp_elements(21) <= simple_obj_ref_64_store_0_ack_1;
    cpelement_group_22 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(12) & cp_elements(23));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(22),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_68_load_0_req_0 <= cp_elements(22);
    cp_elements(23) <= cp_elements(7);
    cp_elements(24) <= simple_obj_ref_68_load_0_ack_0;
    simple_obj_ref_68_load_0_req_1 <= cp_elements(24);
    cp_elements(25) <= simple_obj_ref_68_load_0_ack_1;
    simple_obj_ref_68_gather_scatter_req_0 <= cp_elements(25);
    cp_elements(26) <= simple_obj_ref_68_gather_scatter_ack_0;
    cpelement_group_27 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(29) & cp_elements(26));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(27),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    ptr_deref_76_gather_scatter_req_0 <= cp_elements(27);
    cp_elements(28) <= cp_elements(7);
    cp_elements(29) <= cp_elements(7);
    cp_elements(30) <= ptr_deref_76_gather_scatter_ack_0;
    ptr_deref_76_store_0_req_0 <= cp_elements(30);
    cp_elements(31) <= ptr_deref_76_store_0_ack_0;
    cp_elements(32) <= cp_elements(31);
    ptr_deref_76_store_0_req_1 <= cp_elements(32);
    cp_elements(33) <= ptr_deref_76_store_0_ack_1;
    cpelement_group_34 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(19) & cp_elements(35));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(34),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_80_load_0_req_0 <= cp_elements(34);
    cp_elements(35) <= cp_elements(7);
    cp_elements(36) <= simple_obj_ref_80_load_0_ack_0;
    simple_obj_ref_80_load_0_req_1 <= cp_elements(36);
    cp_elements(37) <= simple_obj_ref_80_load_0_ack_1;
    simple_obj_ref_80_gather_scatter_req_0 <= cp_elements(37);
    cp_elements(38) <= simple_obj_ref_80_gather_scatter_ack_0;
    cpelement_group_39 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(38) & cp_elements(41) & cp_elements(31));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(39),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    ptr_deref_88_gather_scatter_req_0 <= cp_elements(39);
    cp_elements(40) <= cp_elements(7);
    cp_elements(41) <= cp_elements(7);
    cp_elements(42) <= ptr_deref_88_gather_scatter_ack_0;
    ptr_deref_88_store_0_req_0 <= cp_elements(42);
    cp_elements(43) <= ptr_deref_88_store_0_ack_0;
    cp_elements(44) <= cp_elements(43);
    ptr_deref_88_store_0_req_1 <= cp_elements(44);
    cp_elements(45) <= ptr_deref_88_store_0_ack_1;
    cp_elements(46) <= cp_elements(7);
    cpelement_group_47 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(52) & cp_elements(46) & cp_elements(48));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(47),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    ptr_deref_97_gather_scatter_req_0 <= cp_elements(47);
    cp_elements(48) <= cp_elements(7);
    cp_elements(49) <= cp_elements(48);
    ptr_deref_97_base_resize_req_0 <= cp_elements(49);
    cp_elements(50) <= ptr_deref_97_base_resize_ack_0;
    ptr_deref_97_root_address_inst_req_0 <= cp_elements(50);
    cp_elements(51) <= ptr_deref_97_root_address_inst_ack_0;
    ptr_deref_97_addr_0_req_0 <= cp_elements(51);
    cp_elements(52) <= ptr_deref_97_addr_0_ack_0;
    cp_elements(53) <= ptr_deref_97_gather_scatter_ack_0;
    ptr_deref_97_store_0_req_0 <= cp_elements(53);
    cp_elements(54) <= ptr_deref_97_store_0_ack_0;
    ptr_deref_97_store_0_req_1 <= cp_elements(54);
    cp_elements(55) <= ptr_deref_97_store_0_ack_1;
    cpelement_group_56 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(58) & cp_elements(43));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(56),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    ptr_deref_107_load_0_req_0 <= cp_elements(56);
    cp_elements(57) <= cp_elements(7);
    cp_elements(58) <= cp_elements(7);
    cp_elements(59) <= ptr_deref_107_load_0_ack_0;
    ptr_deref_107_load_0_req_1 <= cp_elements(59);
    cp_elements(60) <= ptr_deref_107_load_0_ack_1;
    ptr_deref_107_gather_scatter_req_0 <= cp_elements(60);
    cp_elements(61) <= ptr_deref_107_gather_scatter_ack_0;
    cpelement_group_62 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(64) & cp_elements(43));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(62),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    ptr_deref_116_load_0_req_0 <= cp_elements(62);
    cp_elements(63) <= cp_elements(7);
    cp_elements(64) <= cp_elements(7);
    cp_elements(65) <= ptr_deref_116_load_0_ack_0;
    ptr_deref_116_load_0_req_1 <= cp_elements(65);
    cp_elements(66) <= ptr_deref_116_load_0_ack_1;
    ptr_deref_116_gather_scatter_req_0 <= cp_elements(66);
    cp_elements(67) <= ptr_deref_116_gather_scatter_ack_0;
    cpelement_group_68 : Block -- 
      signal predecessors: BooleanArray(10 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(55) & cp_elements(33) & cp_elements(63) & cp_elements(21) & cp_elements(28) & cp_elements(45) & cp_elements(40) & cp_elements(57) & cp_elements(67) & cp_elements(61) & cp_elements(14));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(68),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(69) <= cp_elements(2);
    cp_elements(70) <= cp_elements(69);
    cp_elements(71) <= cp_elements(69);
    cpelement_group_72 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(71) & cp_elements(70));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(72),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    call_stmt_121_call_req_0 <= cp_elements(72);
    cp_elements(73) <= call_stmt_121_call_ack_0;
    call_stmt_121_call_req_1 <= cp_elements(73);
    cp_elements(74) <= call_stmt_121_call_ack_1;
    cp_elements(75) <= cp_elements(3);
    cp_elements(76) <= cp_elements(75);
    cpelement_group_77 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(78) & cp_elements(76));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(77),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_122_gather_scatter_req_0 <= cp_elements(77);
    cp_elements(78) <= cp_elements(75);
    cp_elements(79) <= simple_obj_ref_122_gather_scatter_ack_0;
    simple_obj_ref_122_store_0_req_0 <= cp_elements(79);
    cp_elements(80) <= simple_obj_ref_122_store_0_ack_0;
    simple_obj_ref_122_store_0_req_1 <= cp_elements(80);
    cp_elements(81) <= simple_obj_ref_122_store_0_ack_1;
    cp_elements(82) <= cp_elements(5);
    simple_obj_ref_128_load_0_req_0 <= cp_elements(82);
    cp_elements(83) <= simple_obj_ref_128_load_0_ack_0;
    simple_obj_ref_128_load_0_req_1 <= cp_elements(83);
    cp_elements(84) <= simple_obj_ref_128_load_0_ack_1;
    simple_obj_ref_128_gather_scatter_req_0 <= cp_elements(84);
    cp_elements(85) <= simple_obj_ref_128_gather_scatter_ack_0;
    cp_elements(86) <= cp_elements(4);
    cp_elements(87) <= cp_elements(86);
    cp_elements(88) <= cp_elements(87);
    cp_elements(89) <= cp_elements(6);
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
    signal cp_elements: BooleanArray(56 downto 0);
    -- 
  begin -- 
    cp_elements(0) <= true when start = '1' else false;
    fin <= '1' when cp_elements(56) else '0';
    cp_elements(1) <= cp_elements(0);
    cp_elements(2) <= cp_elements(48);
    cp_elements(3) <= cp_elements(55);
    cp_elements(4) <= cp_elements(52);
    cp_elements(5) <= cp_elements(1);
    cp_elements(6) <= cp_elements(5);
    cpelement_group_7 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(6) & cp_elements(8));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(7),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_11_gather_scatter_req_0 <= cp_elements(7);
    cp_elements(8) <= cp_elements(5);
    cp_elements(9) <= simple_obj_ref_11_gather_scatter_ack_0;
    simple_obj_ref_11_store_0_req_0 <= cp_elements(9);
    cp_elements(10) <= simple_obj_ref_11_store_0_ack_0;
    cp_elements(11) <= cp_elements(10);
    simple_obj_ref_11_store_0_req_1 <= cp_elements(11);
    cp_elements(12) <= simple_obj_ref_11_store_0_ack_1;
    cp_elements(13) <= cp_elements(5);
    cpelement_group_14 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(13) & cp_elements(15));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(14),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_14_gather_scatter_req_0 <= cp_elements(14);
    cp_elements(15) <= cp_elements(5);
    cp_elements(16) <= simple_obj_ref_14_gather_scatter_ack_0;
    simple_obj_ref_14_store_0_req_0 <= cp_elements(16);
    cp_elements(17) <= simple_obj_ref_14_store_0_ack_0;
    cp_elements(18) <= cp_elements(17);
    simple_obj_ref_14_store_0_req_1 <= cp_elements(18);
    cp_elements(19) <= simple_obj_ref_14_store_0_ack_1;
    cp_elements(20) <= cp_elements(5);
    cp_elements(21) <= cp_elements(5);
    ptr_deref_24_load_0_req_0 <= cp_elements(21);
    cp_elements(22) <= ptr_deref_24_load_0_ack_0;
    ptr_deref_24_load_0_req_1 <= cp_elements(22);
    cp_elements(23) <= ptr_deref_24_load_0_ack_1;
    ptr_deref_24_gather_scatter_req_0 <= cp_elements(23);
    cp_elements(24) <= ptr_deref_24_gather_scatter_ack_0;
    cpelement_group_25 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(26) & cp_elements(10));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(25),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_27_load_0_req_0 <= cp_elements(25);
    cp_elements(26) <= cp_elements(5);
    cp_elements(27) <= simple_obj_ref_27_load_0_ack_0;
    simple_obj_ref_27_load_0_req_1 <= cp_elements(27);
    cp_elements(28) <= simple_obj_ref_27_load_0_ack_1;
    simple_obj_ref_27_gather_scatter_req_0 <= cp_elements(28);
    cp_elements(29) <= simple_obj_ref_27_gather_scatter_ack_0;
    cpelement_group_30 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(24) & cp_elements(29) & cp_elements(31));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(30),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_32_inst_req_0 <= cp_elements(30);
    cp_elements(31) <= cp_elements(5);
    cp_elements(32) <= binary_32_inst_ack_0;
    binary_32_inst_req_1 <= cp_elements(32);
    cp_elements(33) <= binary_32_inst_ack_1;
    cpelement_group_34 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(35) & cp_elements(17));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(34),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_35_load_0_req_0 <= cp_elements(34);
    cp_elements(35) <= cp_elements(5);
    cp_elements(36) <= simple_obj_ref_35_load_0_ack_0;
    simple_obj_ref_35_load_0_req_1 <= cp_elements(36);
    cp_elements(37) <= simple_obj_ref_35_load_0_ack_1;
    simple_obj_ref_35_gather_scatter_req_0 <= cp_elements(37);
    cp_elements(38) <= simple_obj_ref_35_gather_scatter_ack_0;
    cpelement_group_39 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(33) & cp_elements(38) & cp_elements(40));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(39),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_40_inst_req_0 <= cp_elements(39);
    cp_elements(40) <= cp_elements(5);
    cp_elements(41) <= binary_40_inst_ack_0;
    binary_40_inst_req_1 <= cp_elements(41);
    cp_elements(42) <= binary_40_inst_ack_1;
    cpelement_group_43 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(42) & cp_elements(44));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(43),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_42_gather_scatter_req_0 <= cp_elements(43);
    cp_elements(44) <= cp_elements(5);
    cp_elements(45) <= simple_obj_ref_42_gather_scatter_ack_0;
    simple_obj_ref_42_store_0_req_0 <= cp_elements(45);
    cp_elements(46) <= simple_obj_ref_42_store_0_ack_0;
    simple_obj_ref_42_store_0_req_1 <= cp_elements(46);
    cp_elements(47) <= simple_obj_ref_42_store_0_ack_1;
    cpelement_group_48 : Block -- 
      signal predecessors: BooleanArray(3 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(19) & cp_elements(20) & cp_elements(47) & cp_elements(12));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(48),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(49) <= cp_elements(3);
    simple_obj_ref_48_load_0_req_0 <= cp_elements(49);
    cp_elements(50) <= simple_obj_ref_48_load_0_ack_0;
    simple_obj_ref_48_load_0_req_1 <= cp_elements(50);
    cp_elements(51) <= simple_obj_ref_48_load_0_ack_1;
    simple_obj_ref_48_gather_scatter_req_0 <= cp_elements(51);
    cp_elements(52) <= simple_obj_ref_48_gather_scatter_ack_0;
    cp_elements(53) <= cp_elements(2);
    cp_elements(54) <= cp_elements(53);
    cp_elements(55) <= cp_elements(54);
    cp_elements(56) <= cp_elements(4);
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
