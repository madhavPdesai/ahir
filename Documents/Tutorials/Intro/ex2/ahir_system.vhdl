-- VHDL produced by vc2vhdl from virtual circuit (vc) description 
library std;
use std.standard.all;
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
use ahir.functionLibraryComponents.all;
library work;
use work.ahir_system_global_package.all;
entity maxDaemon is -- 
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
    in_data_pipe_read_data : in   std_logic_vector(31 downto 0);
    out_data_pipe_write_req : out  std_logic_vector(0 downto 0);
    out_data_pipe_write_ack : in   std_logic_vector(0 downto 0);
    out_data_pipe_write_data : out  std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
  );
  -- 
end entity maxDaemon;
architecture Default of maxDaemon is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal in_buffer_data_in, in_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal in_buffer_write_req: std_logic;
  signal in_buffer_write_ack: std_logic;
  signal in_buffer_unload_req_symbol: Boolean;
  signal in_buffer_unload_ack_symbol: Boolean;
  signal out_buffer_data_in, out_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal out_buffer_read_req: std_logic;
  signal out_buffer_read_ack: std_logic;
  signal out_buffer_write_req_symbol: Boolean;
  signal out_buffer_write_ack_symbol: Boolean;
  signal default_zero_sig: std_logic;
  signal tag_ub_out, tag_ilock_out: std_logic_vector(tag_length-1 downto 0);
  signal tag_push_req, tag_push_ack, tag_pop_req, tag_pop_ack: std_logic;
  signal tag_unload_req_symbol, tag_unload_ack_symbol, tag_write_req_symbol, tag_write_ack_symbol: Boolean;
  signal tag_ilock_write_req_symbol, tag_ilock_write_ack_symbol, tag_ilock_read_req_symbol, tag_ilock_read_ack_symbol: Boolean;
  signal start_req_sig, fin_req_sig, start_ack_sig, fin_ack_sig: std_logic; 
  signal input_sample_reenable_symbol: Boolean;
  -- input port buffer signals
  -- output port buffer signals
  signal maxDaemon_CP_0_start: Boolean;
  signal maxDaemon_CP_0_symbol: Boolean;
  -- links between control-path and data-path
  signal RPIPE_in_data_8_inst_req_1 : boolean;
  signal RPIPE_in_data_11_inst_req_0 : boolean;
  signal RPIPE_in_data_11_inst_ack_0 : boolean;
  signal RPIPE_in_data_8_inst_req_0 : boolean;
  signal RPIPE_in_data_8_inst_ack_0 : boolean;
  signal RPIPE_in_data_8_inst_ack_1 : boolean;
  signal UGT_u32_u1_16_inst_req_0 : boolean;
  signal UGT_u32_u1_16_inst_ack_0 : boolean;
  signal UGT_u32_u1_16_inst_req_1 : boolean;
  signal UGT_u32_u1_16_inst_ack_1 : boolean;
  signal RPIPE_in_data_11_inst_req_1 : boolean;
  signal RPIPE_in_data_11_inst_ack_1 : boolean;
  signal MUX_23_inst_req_0 : boolean;
  signal MUX_23_inst_ack_0 : boolean;
  signal MUX_23_inst_req_1 : boolean;
  signal MUX_23_inst_ack_1 : boolean;
  signal WPIPE_out_data_25_inst_req_0 : boolean;
  signal WPIPE_out_data_25_inst_ack_0 : boolean;
  signal WPIPE_out_data_25_inst_req_1 : boolean;
  signal WPIPE_out_data_25_inst_ack_1 : boolean;
  -- 
begin --  
  -- input handling ------------------------------------------------
  in_buffer: UnloadBuffer -- 
    generic map(name => "maxDaemon_input_buffer", -- 
      buffer_size => 1,
      data_width => tag_length + 0) -- 
    port map(write_req => in_buffer_write_req, -- 
      write_ack => in_buffer_write_ack, 
      write_data => in_buffer_data_in,
      unload_req => in_buffer_unload_req_symbol, 
      unload_ack => in_buffer_unload_ack_symbol, 
      read_data => in_buffer_data_out,
      clk => clk, reset => reset); -- 
  in_buffer_data_in(tag_length-1 downto 0) <= tag_in;
  tag_ub_out <= in_buffer_data_out(tag_length-1 downto 0);
  in_buffer_write_req <= start_req;
  start_ack <= in_buffer_write_ack;
  in_buffer_unload_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 1,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 32) := "in_buffer_unload_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= in_buffer_unload_ack_symbol & input_sample_reenable_symbol;
    gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => in_buffer_unload_req_symbol, clk => clk, reset => reset); --
  end block;
  -- join of all unload_ack_symbols.. used to trigger CP.
  maxDaemon_CP_0_start <= in_buffer_unload_ack_symbol;
  -- output handling  -------------------------------------------------------
  out_buffer: ReceiveBuffer -- 
    generic map(name => "maxDaemon_out_buffer", -- 
      buffer_size => 1,
      data_width => tag_length + 0, 
      kill_counter_range => 1) -- 
    port map(write_req => out_buffer_write_req_symbol, -- 
      write_ack => out_buffer_write_ack_symbol, 
      write_data => out_buffer_data_in,
      read_req => out_buffer_read_req, 
      read_ack => out_buffer_read_ack, 
      read_data => out_buffer_data_out,
      kill => default_zero_sig,
      clk => clk, reset => reset); -- 
  out_buffer_data_in(tag_length-1 downto 0) <= tag_ilock_out;
  tag_out <= out_buffer_data_out(tag_length-1 downto 0);
  out_buffer_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 0);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 1,2 => 0);
    constant joinName: string(1 to 32) := "out_buffer_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= maxDaemon_CP_0_symbol & out_buffer_write_ack_symbol & tag_ilock_read_ack_symbol;
    gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => out_buffer_write_req_symbol, clk => clk, reset => reset); --
  end block;
  -- write-to output-buffer produces  reenable input sampling
  input_sample_reenable_symbol <= out_buffer_write_ack_symbol;
  -- fin-req/ack level protocol..
  out_buffer_read_req <= fin_req;
  fin_ack <= out_buffer_read_ack;
  ----- tag-queue --------------------------------------------------
  -- interlock buffer for TAG.. to provide required buffering.
  tagIlock: InterlockBuffer -- 
    generic map(name => "tag-interlock-buffer", -- 
      buffer_size => 1,
      in_data_width => tag_length,
      out_data_width => tag_length) -- 
    port map(write_req => tag_ilock_write_req_symbol, -- 
      write_ack => tag_ilock_write_ack_symbol, 
      write_data => tag_ub_out,
      read_req => tag_ilock_read_req_symbol, 
      read_ack => tag_ilock_read_ack_symbol, 
      read_data => tag_ilock_out, 
      clk => clk, reset => reset); -- 
  -- tag ilock-buffer control logic. 
  tag_ilock_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 31) := "tag_ilock_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= maxDaemon_CP_0_start & tag_ilock_write_ack_symbol;
    gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_write_req_symbol, clk => clk, reset => reset); --
  end block;
  tag_ilock_read_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
    constant joinName: string(1 to 30) := "tag_ilock_read_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= maxDaemon_CP_0_start & tag_ilock_read_ack_symbol & out_buffer_write_ack_symbol;
    gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_read_req_symbol, clk => clk, reset => reset); --
  end block;
  -- the control path --------------------------------------------------
  always_true_symbol <= true; 
  default_zero_sig <= '0';
  maxDaemon_CP_0: Block -- control-path 
    signal maxDaemon_CP_0_elements: BooleanArray(31 downto 0);
    -- 
  begin -- 
    maxDaemon_CP_0_elements(0) <= maxDaemon_CP_0_start;
    maxDaemon_CP_0_symbol <= maxDaemon_CP_0_elements(1);
    -- CP-element group 0 transition  place  bypass 
    -- predecessors 
    -- successors 30 
    -- members (6) 
      -- 	$entry
      -- 	branch_block_stmt_4/$entry
      -- 	branch_block_stmt_4/branch_block_stmt_4__entry__
      -- 	branch_block_stmt_4/bb_0_bb_1
      -- 	branch_block_stmt_4/bb_0_bb_1_PhiReq/$entry
      -- 	branch_block_stmt_4/bb_0_bb_1_PhiReq/$exit
      -- 
    -- CP-element group 1 transition  place  bypass 
    -- predecessors 
    -- successors 
    -- members (3) 
      -- 	$exit
      -- 	branch_block_stmt_4/$exit
      -- 	branch_block_stmt_4/branch_block_stmt_4__exit__
      -- 
    maxDaemon_CP_0_elements(1) <= false; 
    -- CP-element group 2 fork  transition  bypass 
    -- predecessors 31 
    -- successors 3 4 
    -- members (1) 
      -- 	branch_block_stmt_4/assign_stmt_9/$entry
      -- 
    maxDaemon_CP_0_elements(2) <= maxDaemon_CP_0_elements(31);
    -- CP-element group 3 transition  output  bypass 
    -- predecessors 2 
    -- successors 5 
    -- members (3) 
      -- 	branch_block_stmt_4/assign_stmt_9/RPIPE_in_data_8_sample_start_
      -- 	branch_block_stmt_4/assign_stmt_9/RPIPE_in_data_8_Sample/$entry
      -- 	branch_block_stmt_4/assign_stmt_9/RPIPE_in_data_8_Sample/rr
      -- 
    maxDaemon_CP_0_elements(3) <= maxDaemon_CP_0_elements(2);
    rr_29_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => maxDaemon_CP_0_elements(3), ack => RPIPE_in_data_8_inst_req_0); -- 
    -- CP-element group 4 transition  output  bypass 
    -- predecessors 2 
    -- successors 6 
    -- members (3) 
      -- 	branch_block_stmt_4/assign_stmt_9/RPIPE_in_data_8_Update/cr
      -- 	branch_block_stmt_4/assign_stmt_9/RPIPE_in_data_8_update_start_
      -- 	branch_block_stmt_4/assign_stmt_9/RPIPE_in_data_8_Update/$entry
      -- 
    maxDaemon_CP_0_elements(4) <= maxDaemon_CP_0_elements(2);
    cr_34_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => maxDaemon_CP_0_elements(4), ack => RPIPE_in_data_8_inst_req_1); -- 
    -- CP-element group 5 transition  input  bypass 
    -- predecessors 3 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_4/assign_stmt_9/RPIPE_in_data_8_sample_completed_
      -- 	branch_block_stmt_4/assign_stmt_9/RPIPE_in_data_8_Sample/$exit
      -- 	branch_block_stmt_4/assign_stmt_9/RPIPE_in_data_8_Sample/ra
      -- 
    ra_30_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_8_inst_ack_0, ack => maxDaemon_CP_0_elements(5)); -- 
    -- CP-element group 6 transition  place  input  bypass 
    -- predecessors 4 
    -- successors 7 
    -- members (6) 
      -- 	branch_block_stmt_4/assign_stmt_9/$exit
      -- 	branch_block_stmt_4/assign_stmt_9__exit__
      -- 	branch_block_stmt_4/assign_stmt_12__entry__
      -- 	branch_block_stmt_4/assign_stmt_9/RPIPE_in_data_8_update_completed_
      -- 	branch_block_stmt_4/assign_stmt_9/RPIPE_in_data_8_Update/$exit
      -- 	branch_block_stmt_4/assign_stmt_9/RPIPE_in_data_8_Update/ca
      -- 
    ca_35_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_8_inst_ack_1, ack => maxDaemon_CP_0_elements(6)); -- 
    -- CP-element group 7 fork  transition  bypass 
    -- predecessors 6 
    -- successors 9 8 
    -- members (1) 
      -- 	branch_block_stmt_4/assign_stmt_12/$entry
      -- 
    maxDaemon_CP_0_elements(7) <= maxDaemon_CP_0_elements(6);
    -- CP-element group 8 transition  output  bypass 
    -- predecessors 7 
    -- successors 10 
    -- members (3) 
      -- 	branch_block_stmt_4/assign_stmt_12/RPIPE_in_data_11_sample_start_
      -- 	branch_block_stmt_4/assign_stmt_12/RPIPE_in_data_11_Sample/$entry
      -- 	branch_block_stmt_4/assign_stmt_12/RPIPE_in_data_11_Sample/rr
      -- 
    maxDaemon_CP_0_elements(8) <= maxDaemon_CP_0_elements(7);
    rr_46_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => maxDaemon_CP_0_elements(8), ack => RPIPE_in_data_11_inst_req_0); -- 
    -- CP-element group 9 transition  output  bypass 
    -- predecessors 7 
    -- successors 11 
    -- members (3) 
      -- 	branch_block_stmt_4/assign_stmt_12/RPIPE_in_data_11_update_start_
      -- 	branch_block_stmt_4/assign_stmt_12/RPIPE_in_data_11_Update/$entry
      -- 	branch_block_stmt_4/assign_stmt_12/RPIPE_in_data_11_Update/cr
      -- 
    maxDaemon_CP_0_elements(9) <= maxDaemon_CP_0_elements(7);
    cr_51_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => maxDaemon_CP_0_elements(9), ack => RPIPE_in_data_11_inst_req_1); -- 
    -- CP-element group 10 transition  input  bypass 
    -- predecessors 8 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_4/assign_stmt_12/RPIPE_in_data_11_sample_completed_
      -- 	branch_block_stmt_4/assign_stmt_12/RPIPE_in_data_11_Sample/$exit
      -- 	branch_block_stmt_4/assign_stmt_12/RPIPE_in_data_11_Sample/ra
      -- 
    ra_47_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_11_inst_ack_0, ack => maxDaemon_CP_0_elements(10)); -- 
    -- CP-element group 11 transition  place  input  bypass 
    -- predecessors 9 
    -- successors 12 
    -- members (6) 
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24__entry__
      -- 	branch_block_stmt_4/assign_stmt_12__exit__
      -- 	branch_block_stmt_4/assign_stmt_12/$exit
      -- 	branch_block_stmt_4/assign_stmt_12/RPIPE_in_data_11_update_completed_
      -- 	branch_block_stmt_4/assign_stmt_12/RPIPE_in_data_11_Update/$exit
      -- 	branch_block_stmt_4/assign_stmt_12/RPIPE_in_data_11_Update/ca
      -- 
    ca_52_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_11_inst_ack_1, ack => maxDaemon_CP_0_elements(11)); -- 
    -- CP-element group 12 fork  transition  bypass 
    -- predecessors 11 
    -- successors 16 15 14 20 21 22 
    -- members (1) 
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/$entry
      -- 
    maxDaemon_CP_0_elements(12) <= maxDaemon_CP_0_elements(11);
    -- CP-element group 13 join  transition  output  bypass 
    -- predecessors 16 15 
    -- successors 17 
    -- members (3) 
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/UGT_u32_u1_16_Sample/$entry
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/UGT_u32_u1_16_Sample/rr
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/UGT_u32_u1_16_sample_start_
      -- 
    cp_element_group_13: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 19) := "cp_element_group_13"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= maxDaemon_CP_0_elements(16) & maxDaemon_CP_0_elements(15);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => maxDaemon_CP_0_elements(13), clk => clk, reset => reset); --
    end block;
    rr_71_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => maxDaemon_CP_0_elements(13), ack => UGT_u32_u1_16_inst_req_0); -- 
    -- CP-element group 14 transition  output  bypass 
    -- predecessors 12 
    -- successors 18 
    -- members (3) 
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/UGT_u32_u1_16_Update/$entry
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/UGT_u32_u1_16_Update/cr
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/UGT_u32_u1_16_update_start_
      -- 
    maxDaemon_CP_0_elements(14) <= maxDaemon_CP_0_elements(12);
    cr_76_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => maxDaemon_CP_0_elements(14), ack => UGT_u32_u1_16_inst_req_1); -- 
    -- CP-element group 15 transition  bypass 
    -- predecessors 12 
    -- successors 13 
    -- members (4) 
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_2_14_sample_start_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_2_14_sample_completed_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_2_14_update_start_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_2_14_update_completed_
      -- 
    maxDaemon_CP_0_elements(15) <= maxDaemon_CP_0_elements(12);
    -- CP-element group 16 transition  bypass 
    -- predecessors 12 
    -- successors 13 
    -- members (4) 
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_4_15_sample_start_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_4_15_sample_completed_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_4_15_update_start_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_4_15_update_completed_
      -- 
    maxDaemon_CP_0_elements(16) <= maxDaemon_CP_0_elements(12);
    -- CP-element group 17 transition  input  bypass 
    -- predecessors 13 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/UGT_u32_u1_16_Sample/$exit
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/UGT_u32_u1_16_Sample/ra
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/UGT_u32_u1_16_sample_completed_
      -- 
    ra_72_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => UGT_u32_u1_16_inst_ack_0, ack => maxDaemon_CP_0_elements(17)); -- 
    -- CP-element group 18 transition  input  bypass 
    -- predecessors 14 
    -- successors 19 
    -- members (7) 
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/UGT_u32_u1_16_Update/$exit
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/UGT_u32_u1_16_Update/ca
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/UGT_u32_u1_16_update_completed_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_5_20_sample_start_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_5_20_sample_completed_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_5_20_update_start_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_5_20_update_completed_
      -- 
    ca_77_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => UGT_u32_u1_16_inst_ack_1, ack => maxDaemon_CP_0_elements(18)); -- 
    -- CP-element group 19 join  transition  output  bypass 
    -- predecessors 18 21 22 
    -- successors 23 
    -- members (3) 
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/MUX_23_sample_start_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/MUX_23_start/$entry
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/MUX_23_start/req
      -- 
    cp_element_group_19: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 19) := "cp_element_group_19"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= maxDaemon_CP_0_elements(18) & maxDaemon_CP_0_elements(21) & maxDaemon_CP_0_elements(22);
      gj : generic_join generic map(name => joinName, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => maxDaemon_CP_0_elements(19), clk => clk, reset => reset); --
    end block;
    req_97_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => maxDaemon_CP_0_elements(19), ack => MUX_23_inst_req_0); -- 
    -- CP-element group 20 transition  output  bypass 
    -- predecessors 12 
    -- successors 24 
    -- members (3) 
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/MUX_23_update_start_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/MUX_23_complete/$entry
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/MUX_23_complete/req
      -- 
    maxDaemon_CP_0_elements(20) <= maxDaemon_CP_0_elements(12);
    req_102_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => maxDaemon_CP_0_elements(20), ack => MUX_23_inst_req_1); -- 
    -- CP-element group 21 transition  bypass 
    -- predecessors 12 
    -- successors 19 
    -- members (4) 
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_2_21_sample_start_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_2_21_sample_completed_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_2_21_update_start_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_2_21_update_completed_
      -- 
    maxDaemon_CP_0_elements(21) <= maxDaemon_CP_0_elements(12);
    -- CP-element group 22 transition  bypass 
    -- predecessors 12 
    -- successors 19 
    -- members (4) 
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_4_22_update_start_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_4_22_update_completed_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_4_22_sample_start_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/R_iNsTr_4_22_sample_completed_
      -- 
    maxDaemon_CP_0_elements(22) <= maxDaemon_CP_0_elements(12);
    -- CP-element group 23 transition  input  bypass 
    -- predecessors 19 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/MUX_23_sample_completed_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/MUX_23_start/$exit
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/MUX_23_start/ack
      -- 
    ack_98_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => MUX_23_inst_ack_0, ack => maxDaemon_CP_0_elements(23)); -- 
    -- CP-element group 24 transition  place  input  bypass 
    -- predecessors 20 
    -- successors 25 
    -- members (6) 
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24__exit__
      -- 	branch_block_stmt_4/assign_stmt_27__entry__
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/$exit
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/MUX_23_update_completed_
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/MUX_23_complete/$exit
      -- 	branch_block_stmt_4/assign_stmt_18_to_assign_stmt_24/MUX_23_complete/ack
      -- 
    ack_103_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => MUX_23_inst_ack_1, ack => maxDaemon_CP_0_elements(24)); -- 
    -- CP-element group 25 fork  transition  bypass 
    -- predecessors 24 
    -- successors 26 27 
    -- members (1) 
      -- 	branch_block_stmt_4/assign_stmt_27/$entry
      -- 
    maxDaemon_CP_0_elements(25) <= maxDaemon_CP_0_elements(24);
    -- CP-element group 26 transition  output  bypass 
    -- predecessors 25 
    -- successors 28 
    -- members (7) 
      -- 	branch_block_stmt_4/assign_stmt_27/R_iNsTr_6_26_sample_start_
      -- 	branch_block_stmt_4/assign_stmt_27/R_iNsTr_6_26_sample_completed_
      -- 	branch_block_stmt_4/assign_stmt_27/R_iNsTr_6_26_update_start_
      -- 	branch_block_stmt_4/assign_stmt_27/R_iNsTr_6_26_update_completed_
      -- 	branch_block_stmt_4/assign_stmt_27/WPIPE_out_data_25_sample_start_
      -- 	branch_block_stmt_4/assign_stmt_27/WPIPE_out_data_25_Sample/$entry
      -- 	branch_block_stmt_4/assign_stmt_27/WPIPE_out_data_25_Sample/req
      -- 
    maxDaemon_CP_0_elements(26) <= maxDaemon_CP_0_elements(25);
    req_118_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => maxDaemon_CP_0_elements(26), ack => WPIPE_out_data_25_inst_req_0); -- 
    -- CP-element group 27 transition  output  bypass 
    -- predecessors 25 
    -- successors 29 
    -- members (3) 
      -- 	branch_block_stmt_4/assign_stmt_27/WPIPE_out_data_25_update_start_
      -- 	branch_block_stmt_4/assign_stmt_27/WPIPE_out_data_25_Update/$entry
      -- 	branch_block_stmt_4/assign_stmt_27/WPIPE_out_data_25_Update/req
      -- 
    maxDaemon_CP_0_elements(27) <= maxDaemon_CP_0_elements(25);
    req_123_symbol_link_to_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => maxDaemon_CP_0_elements(27), ack => WPIPE_out_data_25_inst_req_1); -- 
    -- CP-element group 28 transition  input  bypass 
    -- predecessors 26 
    -- successors 
    -- members (3) 
      -- 	branch_block_stmt_4/assign_stmt_27/WPIPE_out_data_25_sample_completed_
      -- 	branch_block_stmt_4/assign_stmt_27/WPIPE_out_data_25_Sample/$exit
      -- 	branch_block_stmt_4/assign_stmt_27/WPIPE_out_data_25_Sample/ack
      -- 
    ack_119_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_out_data_25_inst_ack_0, ack => maxDaemon_CP_0_elements(28)); -- 
    -- CP-element group 29 transition  place  input  bypass 
    -- predecessors 27 
    -- successors 30 
    -- members (8) 
      -- 	branch_block_stmt_4/assign_stmt_27__exit__
      -- 	branch_block_stmt_4/bb_1_bb_1
      -- 	branch_block_stmt_4/assign_stmt_27/$exit
      -- 	branch_block_stmt_4/assign_stmt_27/WPIPE_out_data_25_update_completed_
      -- 	branch_block_stmt_4/assign_stmt_27/WPIPE_out_data_25_Update/$exit
      -- 	branch_block_stmt_4/assign_stmt_27/WPIPE_out_data_25_Update/ack
      -- 	branch_block_stmt_4/bb_1_bb_1_PhiReq/$entry
      -- 	branch_block_stmt_4/bb_1_bb_1_PhiReq/$exit
      -- 
    ack_124_symbol_link_from_dp: control_delay_element -- 
      generic map (delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_out_data_25_inst_ack_1, ack => maxDaemon_CP_0_elements(29)); -- 
    -- CP-element group 30 merge  place  bypass 
    -- predecessors 0 29 
    -- successors 31 
    -- members (1) 
      -- 	branch_block_stmt_4/merge_stmt_6_PhiReqMerge
      -- 
    maxDaemon_CP_0_elements(30) <= OrReduce(maxDaemon_CP_0_elements(0) & maxDaemon_CP_0_elements(29));
    -- CP-element group 31 transition  place  bypass 
    -- predecessors 30 
    -- successors 2 
    -- members (5) 
      -- 	branch_block_stmt_4/merge_stmt_6__exit__
      -- 	branch_block_stmt_4/assign_stmt_9__entry__
      -- 	branch_block_stmt_4/merge_stmt_6_PhiAck/$entry
      -- 	branch_block_stmt_4/merge_stmt_6_PhiAck/$exit
      -- 	branch_block_stmt_4/merge_stmt_6_PhiAck/dummy
      -- 
    maxDaemon_CP_0_elements(31) <= maxDaemon_CP_0_elements(30);
    --  hookup: inputs to control-path 
    -- hookup: output from control-path 
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal iNsTr_2_9 : std_logic_vector(31 downto 0);
    signal iNsTr_4_12 : std_logic_vector(31 downto 0);
    signal iNsTr_5_18 : std_logic_vector(0 downto 0);
    signal iNsTr_6_24 : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    MUX_23_inst_block : block -- 
      signal sample_req, sample_ack, update_req, update_ack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      sample_req(0) <= MUX_23_inst_req_0;
      MUX_23_inst_ack_0<= sample_ack(0);
      update_req(0) <= MUX_23_inst_req_1;
      MUX_23_inst_ack_1<= update_ack(0);
      MUX_23_inst: SelectSplitProtocol generic map(name => "MUX_23_inst", data_width => 32, buffering => 1, flow_through => false) -- 
        port map( x => iNsTr_2_9, y => iNsTr_4_12, sel => iNsTr_5_18, z => iNsTr_6_24, sample_req => sample_req(0), sample_ack => sample_ack(0), update_req => update_req(0), update_ack => update_ack(0), clk => clk, reset => reset); -- 
      -- 
    end block;
    -- shared split operator group (0) : UGT_u32_u1_16_inst 
    ApIntUgt_group_0: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded, reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      data_in <= iNsTr_2_9 & iNsTr_4_12;
      iNsTr_5_18 <= data_out(0 downto 0);
      guard_vector(0)  <=  '1';
      reqL_unguarded(0) <= UGT_u32_u1_16_inst_req_0;
      UGT_u32_u1_16_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= UGT_u32_u1_16_inst_req_1;
      UGT_u32_u1_16_inst_ack_1 <= ackR_unguarded(0);
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      UnsharedOperator: UnsharedOperatorWithBuffering -- 
        generic map ( -- 
          operator_id => "ApIntUgt",
          name => "ApIntUgt_group_0",
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
          buffering  => 1,
          flow_through => false,
          use_constant  => false
          --
        ) 
        port map ( -- 
          reqL => reqL(0),
          ackL => ackL(0),
          reqR => reqR(0),
          ackR => ackR(0),
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared inport operator group (0) : RPIPE_in_data_8_inst RPIPE_in_data_11_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(63 downto 0);
      signal reqL, ackL, reqR, ackR : BooleanArray( 1 downto 0);
      signal reqL_unguarded, ackL_unguarded : BooleanArray( 1 downto 0);
      signal reqR_unguarded, ackR_unguarded : BooleanArray( 1 downto 0);
      signal guard_vector : std_logic_vector( 1 downto 0);
      constant outBUFs : IntegerArray(1 downto 0) := (1 => 1, 0 => 1);
      constant guardFlags : BooleanArray(1 downto 0) := (0 => false, 1 => false);
      constant guardBuffering: IntegerArray(1 downto 0)  := (0 => 1, 1 => 1);
      -- 
    begin -- 
      reqL_unguarded(1) <= RPIPE_in_data_8_inst_req_0;
      reqL_unguarded(0) <= RPIPE_in_data_11_inst_req_0;
      RPIPE_in_data_8_inst_ack_0 <= ackL_unguarded(1);
      RPIPE_in_data_11_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(1) <= RPIPE_in_data_8_inst_req_1;
      reqR_unguarded(0) <= RPIPE_in_data_11_inst_req_1;
      RPIPE_in_data_8_inst_ack_1 <= ackR_unguarded(1);
      RPIPE_in_data_11_inst_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <=  '1';
      guard_vector(1)  <=  '1';
      gI: SplitGuardInterface generic map(nreqs => 2, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      iNsTr_2_9 <= data_out(63 downto 32);
      iNsTr_4_12 <= data_out(31 downto 0);
      in_data_read_0: InputPortFullRate -- 
        generic map ( name => "in_data_read_0", data_width => 32,  num_reqs => 2,  output_buffering => outBUFs,   no_arbitration => false)
        port map (-- 
          sample_req => reqL , 
          sample_ack => ackL, 
          update_req => reqR, 
          update_ack => ackR, 
          data => data_out, 
          oreq => in_data_pipe_read_req(0),
          oack => in_data_pipe_read_ack(0),
          odata => in_data_pipe_read_data(31 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared outport operator group (0) : WPIPE_out_data_25_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal sample_req, sample_ack : BooleanArray( 0 downto 0);
      signal update_req, update_ack : BooleanArray( 0 downto 0);
      signal sample_req_unguarded, sample_ack_unguarded : BooleanArray( 0 downto 0);
      signal update_req_unguarded, update_ack_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 1);
      -- 
    begin -- 
      sample_req_unguarded(0) <= WPIPE_out_data_25_inst_req_0;
      WPIPE_out_data_25_inst_ack_0 <= sample_ack_unguarded(0);
      update_req_unguarded(0) <= WPIPE_out_data_25_inst_req_1;
      WPIPE_out_data_25_inst_ack_1 <= update_ack_unguarded(0);
      guard_vector(0)  <=  '1';
      gI: SplitGuardInterface generic map(nreqs => 1, buffering => guardBuffering, use_guards => guardFlags) -- 
        port map(clk => clk, reset => reset,
        sr_in => sample_req_unguarded,
        sr_out => sample_req,
        sa_in => sample_ack,
        sa_out => sample_ack_unguarded,
        cr_in => update_req_unguarded,
        cr_out => update_req,
        ca_in => update_ack,
        ca_out => update_ack_unguarded,
        guards => guard_vector); -- 
      data_in <= iNsTr_6_24;
      out_data_write_0: OutputPortFullRate -- 
        generic map ( name => "out_data", data_width => 32, num_reqs => 1, input_buffering => inBUFs, no_arbitration => false)
        port map (--
          sample_req => sample_req , 
          sample_ack => sample_ack , 
          update_req => update_req , 
          update_ack => update_ack , 
          data => data_in, 
          oreq => out_data_pipe_write_req(0),
          oack => out_data_pipe_write_ack(0),
          odata => out_data_pipe_write_data(31 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    -- 
  end Block; -- data_path
  -- 
end Default;
library std;
use std.standard.all;
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
use ahir.functionLibraryComponents.all;
library work;
use work.ahir_system_global_package.all;
entity ahir_system is  -- system 
  port (-- 
    clk : in std_logic;
    reset : in std_logic;
    in_data_pipe_write_data: in std_logic_vector(31 downto 0);
    in_data_pipe_write_req : in std_logic_vector(0 downto 0);
    in_data_pipe_write_ack : out std_logic_vector(0 downto 0);
    out_data_pipe_read_data: out std_logic_vector(31 downto 0);
    out_data_pipe_read_req : in std_logic_vector(0 downto 0);
    out_data_pipe_read_ack : out std_logic_vector(0 downto 0)); -- 
  -- 
end entity; 
architecture Default of ahir_system is -- system-architecture 
  -- declarations related to module maxDaemon
  component maxDaemon is -- 
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
      in_data_pipe_read_data : in   std_logic_vector(31 downto 0);
      out_data_pipe_write_req : out  std_logic_vector(0 downto 0);
      out_data_pipe_write_ack : in   std_logic_vector(0 downto 0);
      out_data_pipe_write_data : out  std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
    -- 
  end component;
  -- argument signals for module maxDaemon
  signal maxDaemon_tag_in    : std_logic_vector(1 downto 0) := (others => '0');
  signal maxDaemon_tag_out   : std_logic_vector(1 downto 0);
  signal maxDaemon_start_req : std_logic;
  signal maxDaemon_start_ack : std_logic;
  signal maxDaemon_fin_req   : std_logic;
  signal maxDaemon_fin_ack : std_logic;
  -- aggregate signals for read from pipe in_data
  signal in_data_pipe_read_data: std_logic_vector(31 downto 0);
  signal in_data_pipe_read_req: std_logic_vector(0 downto 0);
  signal in_data_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe out_data
  signal out_data_pipe_write_data: std_logic_vector(31 downto 0);
  signal out_data_pipe_write_req: std_logic_vector(0 downto 0);
  signal out_data_pipe_write_ack: std_logic_vector(0 downto 0);
  -- 
begin -- 
  -- module maxDaemon
  maxDaemon_instance:maxDaemon-- 
    generic map(tag_length => 2)
    port map(-- 
      start_req => maxDaemon_start_req,
      start_ack => maxDaemon_start_ack,
      fin_req => maxDaemon_fin_req,
      fin_ack => maxDaemon_fin_ack,
      clk => clk,
      reset => reset,
      in_data_pipe_read_req => in_data_pipe_read_req(0 downto 0),
      in_data_pipe_read_ack => in_data_pipe_read_ack(0 downto 0),
      in_data_pipe_read_data => in_data_pipe_read_data(31 downto 0),
      out_data_pipe_write_req => out_data_pipe_write_req(0 downto 0),
      out_data_pipe_write_ack => out_data_pipe_write_ack(0 downto 0),
      out_data_pipe_write_data => out_data_pipe_write_data(31 downto 0),
      tag_in => maxDaemon_tag_in,
      tag_out => maxDaemon_tag_out-- 
    ); -- 
  -- module will be run forever 
  maxDaemon_tag_in <= (others => '0');
  maxDaemon_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => maxDaemon_start_req, start_ack => maxDaemon_start_ack,  fin_req => maxDaemon_fin_req,  fin_ack => maxDaemon_fin_ack);
  in_data_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe in_data",
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      lifo_mode => false,
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
  out_data_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe out_data",
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      lifo_mode => false,
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
