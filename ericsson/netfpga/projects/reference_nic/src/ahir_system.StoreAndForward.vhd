-- VHDL produced by vc2vhdl from virtual circuit (vc) description 
library ieee;
use ieee.std_logic_1164.all;
package vc_system_package is -- 
  constant packet_control_buffer_base_address : std_logic_vector(9 downto 0) := "0000000000";
  constant packet_data_buffer_base_address : std_logic_vector(9 downto 0) := "0000000000";
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
entity get_packet is -- 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    free_index_pipe_pipe_read_req : out  std_logic_vector(0 downto 0);
    free_index_pipe_pipe_read_ack : in   std_logic_vector(0 downto 0);
    free_index_pipe_pipe_read_data : in   std_logic_vector(31 downto 0);
    send_msg_pipe_write_req : out  std_logic_vector(0 downto 0);
    send_msg_pipe_write_ack : in   std_logic_vector(0 downto 0);
    send_msg_pipe_write_data : out  std_logic_vector(31 downto 0);
    store_packet_call_reqs : out  std_logic_vector(0 downto 0);
    store_packet_call_acks : in   std_logic_vector(0 downto 0);
    store_packet_call_data : out  std_logic_vector(63 downto 0);
    store_packet_call_tag  :  out  std_logic_vector(0 downto 0);
    store_packet_return_reqs : out  std_logic_vector(0 downto 0);
    store_packet_return_acks : in   std_logic_vector(0 downto 0);
    store_packet_return_data : in   std_logic_vector(31 downto 0);
    store_packet_return_tag :  in   std_logic_vector(0 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity get_packet;
architecture Default of get_packet is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal simple_obj_ref_20_inst_req_0 : boolean;
  signal simple_obj_ref_20_inst_ack_0 : boolean;
  signal array_obj_ref_25_index_0_resize_req_0 : boolean;
  signal array_obj_ref_25_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_25_index_0_scale_req_0 : boolean;
  signal array_obj_ref_25_index_0_scale_ack_0 : boolean;
  signal array_obj_ref_25_index_0_scale_req_1 : boolean;
  signal array_obj_ref_25_index_0_scale_ack_1 : boolean;
  signal array_obj_ref_25_index_sum_1_req_0 : boolean;
  signal array_obj_ref_25_index_sum_1_ack_0 : boolean;
  signal array_obj_ref_25_index_sum_1_req_1 : boolean;
  signal array_obj_ref_25_index_sum_1_ack_1 : boolean;
  signal array_obj_ref_25_offset_inst_req_0 : boolean;
  signal array_obj_ref_25_offset_inst_ack_0 : boolean;
  signal array_obj_ref_25_root_address_inst_req_0 : boolean;
  signal array_obj_ref_25_root_address_inst_ack_0 : boolean;
  signal addr_of_26_final_reg_req_0 : boolean;
  signal addr_of_26_final_reg_ack_0 : boolean;
  signal array_obj_ref_31_index_0_resize_req_0 : boolean;
  signal array_obj_ref_31_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_31_index_0_scale_req_0 : boolean;
  signal array_obj_ref_31_index_0_scale_ack_0 : boolean;
  signal array_obj_ref_31_index_0_scale_req_1 : boolean;
  signal array_obj_ref_31_index_0_scale_ack_1 : boolean;
  signal array_obj_ref_31_index_sum_1_req_0 : boolean;
  signal array_obj_ref_31_index_sum_1_ack_0 : boolean;
  signal array_obj_ref_31_index_sum_1_req_1 : boolean;
  signal array_obj_ref_31_index_sum_1_ack_1 : boolean;
  signal array_obj_ref_31_offset_inst_req_0 : boolean;
  signal array_obj_ref_31_offset_inst_ack_0 : boolean;
  signal array_obj_ref_31_root_address_inst_req_0 : boolean;
  signal array_obj_ref_31_root_address_inst_ack_0 : boolean;
  signal addr_of_32_final_reg_req_0 : boolean;
  signal addr_of_32_final_reg_ack_0 : boolean;
  signal call_stmt_37_call_req_0 : boolean;
  signal call_stmt_37_call_ack_0 : boolean;
  signal call_stmt_37_call_req_1 : boolean;
  signal call_stmt_37_call_ack_1 : boolean;
  signal simple_obj_ref_38_inst_req_0 : boolean;
  signal simple_obj_ref_38_inst_ack_0 : boolean;
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
  get_packet_CP_323: Block -- control-path 
    signal get_packet_CP_323_start: Boolean;
    signal Xentry_324_symbol: Boolean;
    signal Xexit_325_symbol: Boolean;
    signal branch_block_stmt_16_326_symbol : Boolean;
    -- 
  begin -- 
    get_packet_CP_323_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_324_symbol  <= get_packet_CP_323_start; -- transition $entry
    branch_block_stmt_16_326: Block -- branch_block_stmt_16 
      signal branch_block_stmt_16_326_start: Boolean;
      signal Xentry_327_symbol: Boolean;
      signal Xexit_328_symbol: Boolean;
      signal branch_block_stmt_16_x_xentry_x_xx_x329_symbol : Boolean;
      signal branch_block_stmt_16_x_xexit_x_xx_x330_symbol : Boolean;
      signal bb_0_bb_1_331_symbol : Boolean;
      signal merge_stmt_18_x_xexit_x_xx_x332_symbol : Boolean;
      signal assign_stmt_21_x_xentry_x_xx_x333_symbol : Boolean;
      signal assign_stmt_21_x_xexit_x_xx_x334_symbol : Boolean;
      signal assign_stmt_27_to_assign_stmt_33_x_xentry_x_xx_x335_symbol : Boolean;
      signal assign_stmt_27_to_assign_stmt_33_x_xexit_x_xx_x336_symbol : Boolean;
      signal call_stmt_37_x_xentry_x_xx_x337_symbol : Boolean;
      signal call_stmt_37_x_xexit_x_xx_x338_symbol : Boolean;
      signal assign_stmt_40_x_xentry_x_xx_x339_symbol : Boolean;
      signal assign_stmt_40_x_xexit_x_xx_x340_symbol : Boolean;
      signal bb_1_bb_1_341_symbol : Boolean;
      signal assign_stmt_21_342_symbol : Boolean;
      signal assign_stmt_27_to_assign_stmt_33_353_symbol : Boolean;
      signal call_stmt_37_438_symbol : Boolean;
      signal assign_stmt_40_457_symbol : Boolean;
      signal bb_0_bb_1_PhiReq_469_symbol : Boolean;
      signal bb_1_bb_1_PhiReq_472_symbol : Boolean;
      signal merge_stmt_18_PhiReqMerge_475_symbol : Boolean;
      signal merge_stmt_18_PhiAck_476_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_16_326_start <= Xentry_324_symbol; -- control passed to block
      Xentry_327_symbol  <= branch_block_stmt_16_326_start; -- transition branch_block_stmt_16/$entry
      branch_block_stmt_16_x_xentry_x_xx_x329_symbol  <=  Xentry_327_symbol; -- place branch_block_stmt_16/branch_block_stmt_16__entry__ (optimized away) 
      branch_block_stmt_16_x_xexit_x_xx_x330_symbol  <=   false ; -- place branch_block_stmt_16/branch_block_stmt_16__exit__ (optimized away) 
      bb_0_bb_1_331_symbol  <=  branch_block_stmt_16_x_xentry_x_xx_x329_symbol; -- place branch_block_stmt_16/bb_0_bb_1 (optimized away) 
      merge_stmt_18_x_xexit_x_xx_x332_symbol  <=  merge_stmt_18_PhiAck_476_symbol; -- place branch_block_stmt_16/merge_stmt_18__exit__ (optimized away) 
      assign_stmt_21_x_xentry_x_xx_x333_symbol  <=  merge_stmt_18_x_xexit_x_xx_x332_symbol; -- place branch_block_stmt_16/assign_stmt_21__entry__ (optimized away) 
      assign_stmt_21_x_xexit_x_xx_x334_symbol  <=  assign_stmt_21_342_symbol; -- place branch_block_stmt_16/assign_stmt_21__exit__ (optimized away) 
      assign_stmt_27_to_assign_stmt_33_x_xentry_x_xx_x335_symbol  <=  assign_stmt_21_x_xexit_x_xx_x334_symbol; -- place branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33__entry__ (optimized away) 
      assign_stmt_27_to_assign_stmt_33_x_xexit_x_xx_x336_symbol  <=  assign_stmt_27_to_assign_stmt_33_353_symbol; -- place branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33__exit__ (optimized away) 
      call_stmt_37_x_xentry_x_xx_x337_symbol  <=  assign_stmt_27_to_assign_stmt_33_x_xexit_x_xx_x336_symbol; -- place branch_block_stmt_16/call_stmt_37__entry__ (optimized away) 
      call_stmt_37_x_xexit_x_xx_x338_symbol  <=  call_stmt_37_438_symbol; -- place branch_block_stmt_16/call_stmt_37__exit__ (optimized away) 
      assign_stmt_40_x_xentry_x_xx_x339_symbol  <=  call_stmt_37_x_xexit_x_xx_x338_symbol; -- place branch_block_stmt_16/assign_stmt_40__entry__ (optimized away) 
      assign_stmt_40_x_xexit_x_xx_x340_symbol  <=  assign_stmt_40_457_symbol; -- place branch_block_stmt_16/assign_stmt_40__exit__ (optimized away) 
      bb_1_bb_1_341_symbol  <=  assign_stmt_40_x_xexit_x_xx_x340_symbol; -- place branch_block_stmt_16/bb_1_bb_1 (optimized away) 
      assign_stmt_21_342: Block -- branch_block_stmt_16/assign_stmt_21 
        signal assign_stmt_21_342_start: Boolean;
        signal Xentry_343_symbol: Boolean;
        signal Xexit_344_symbol: Boolean;
        signal assign_stmt_21_active_x_x345_symbol : Boolean;
        signal assign_stmt_21_completed_x_x346_symbol : Boolean;
        signal simple_obj_ref_20_trigger_x_x347_symbol : Boolean;
        signal simple_obj_ref_20_complete_348_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_21_342_start <= assign_stmt_21_x_xentry_x_xx_x333_symbol; -- control passed to block
        Xentry_343_symbol  <= assign_stmt_21_342_start; -- transition branch_block_stmt_16/assign_stmt_21/$entry
        assign_stmt_21_active_x_x345_symbol <= simple_obj_ref_20_complete_348_symbol; -- transition branch_block_stmt_16/assign_stmt_21/assign_stmt_21_active_
        assign_stmt_21_completed_x_x346_symbol <= assign_stmt_21_active_x_x345_symbol; -- transition branch_block_stmt_16/assign_stmt_21/assign_stmt_21_completed_
        simple_obj_ref_20_trigger_x_x347_symbol <= Xentry_343_symbol; -- transition branch_block_stmt_16/assign_stmt_21/simple_obj_ref_20_trigger_
        simple_obj_ref_20_complete_348: Block -- branch_block_stmt_16/assign_stmt_21/simple_obj_ref_20_complete 
          signal simple_obj_ref_20_complete_348_start: Boolean;
          signal Xentry_349_symbol: Boolean;
          signal Xexit_350_symbol: Boolean;
          signal req_351_symbol : Boolean;
          signal ack_352_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_20_complete_348_start <= simple_obj_ref_20_trigger_x_x347_symbol; -- control passed to block
          Xentry_349_symbol  <= simple_obj_ref_20_complete_348_start; -- transition branch_block_stmt_16/assign_stmt_21/simple_obj_ref_20_complete/$entry
          req_351_symbol <= Xentry_349_symbol; -- transition branch_block_stmt_16/assign_stmt_21/simple_obj_ref_20_complete/req
          simple_obj_ref_20_inst_req_0 <= req_351_symbol; -- link to DP
          ack_352_symbol <= simple_obj_ref_20_inst_ack_0; -- transition branch_block_stmt_16/assign_stmt_21/simple_obj_ref_20_complete/ack
          Xexit_350_symbol <= ack_352_symbol; -- transition branch_block_stmt_16/assign_stmt_21/simple_obj_ref_20_complete/$exit
          simple_obj_ref_20_complete_348_symbol <= Xexit_350_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_16/assign_stmt_21/simple_obj_ref_20_complete
        Xexit_344_symbol <= assign_stmt_21_completed_x_x346_symbol; -- transition branch_block_stmt_16/assign_stmt_21/$exit
        assign_stmt_21_342_symbol <= Xexit_344_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_16/assign_stmt_21
      assign_stmt_27_to_assign_stmt_33_353: Block -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33 
        signal assign_stmt_27_to_assign_stmt_33_353_start: Boolean;
        signal Xentry_354_symbol: Boolean;
        signal Xexit_355_symbol: Boolean;
        signal assign_stmt_27_active_x_x356_symbol : Boolean;
        signal assign_stmt_27_completed_x_x357_symbol : Boolean;
        signal addr_of_26_active_x_x358_symbol : Boolean;
        signal addr_of_26_trigger_x_x359_symbol : Boolean;
        signal array_obj_ref_25_root_address_calculated_360_symbol : Boolean;
        signal array_obj_ref_25_indices_scaled_361_symbol : Boolean;
        signal array_obj_ref_25_offset_calculated_362_symbol : Boolean;
        signal array_obj_ref_25_index_computed_0_363_symbol : Boolean;
        signal array_obj_ref_25_index_resized_0_364_symbol : Boolean;
        signal simple_obj_ref_23_complete_365_symbol : Boolean;
        signal array_obj_ref_25_index_resize_0_366_symbol : Boolean;
        signal array_obj_ref_25_index_scale_0_371_symbol : Boolean;
        signal array_obj_ref_25_add_indices_378_symbol : Boolean;
        signal array_obj_ref_25_base_plus_offset_387_symbol : Boolean;
        signal addr_of_26_complete_392_symbol : Boolean;
        signal assign_stmt_33_active_x_x397_symbol : Boolean;
        signal assign_stmt_33_completed_x_x398_symbol : Boolean;
        signal addr_of_32_active_x_x399_symbol : Boolean;
        signal addr_of_32_trigger_x_x400_symbol : Boolean;
        signal array_obj_ref_31_root_address_calculated_401_symbol : Boolean;
        signal array_obj_ref_31_indices_scaled_402_symbol : Boolean;
        signal array_obj_ref_31_offset_calculated_403_symbol : Boolean;
        signal array_obj_ref_31_index_computed_0_404_symbol : Boolean;
        signal array_obj_ref_31_index_resized_0_405_symbol : Boolean;
        signal simple_obj_ref_29_complete_406_symbol : Boolean;
        signal array_obj_ref_31_index_resize_0_407_symbol : Boolean;
        signal array_obj_ref_31_index_scale_0_412_symbol : Boolean;
        signal array_obj_ref_31_add_indices_419_symbol : Boolean;
        signal array_obj_ref_31_base_plus_offset_428_symbol : Boolean;
        signal addr_of_32_complete_433_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_27_to_assign_stmt_33_353_start <= assign_stmt_27_to_assign_stmt_33_x_xentry_x_xx_x335_symbol; -- control passed to block
        Xentry_354_symbol  <= assign_stmt_27_to_assign_stmt_33_353_start; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/$entry
        assign_stmt_27_active_x_x356_symbol <= addr_of_26_complete_392_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/assign_stmt_27_active_
        assign_stmt_27_completed_x_x357_symbol <= assign_stmt_27_active_x_x356_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/assign_stmt_27_completed_
        addr_of_26_active_x_x358_block : Block -- non-trivial join transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_26_active_ 
          signal addr_of_26_active_x_x358_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          addr_of_26_active_x_x358_predecessors(0) <= addr_of_26_trigger_x_x359_symbol;
          addr_of_26_active_x_x358_predecessors(1) <= array_obj_ref_25_root_address_calculated_360_symbol;
          addr_of_26_active_x_x358_join: join -- 
            port map( -- 
              preds => addr_of_26_active_x_x358_predecessors,
              symbol_out => addr_of_26_active_x_x358_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_26_active_
        addr_of_26_trigger_x_x359_symbol <= Xentry_354_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_26_trigger_
        array_obj_ref_25_root_address_calculated_360_symbol <= array_obj_ref_25_base_plus_offset_387_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_root_address_calculated
        array_obj_ref_25_indices_scaled_361_symbol <= array_obj_ref_25_index_scale_0_371_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_indices_scaled
        array_obj_ref_25_offset_calculated_362_symbol <= array_obj_ref_25_add_indices_378_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_offset_calculated
        array_obj_ref_25_index_computed_0_363_symbol <= simple_obj_ref_23_complete_365_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_index_computed_0
        array_obj_ref_25_index_resized_0_364_symbol <= array_obj_ref_25_index_resize_0_366_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_index_resized_0
        simple_obj_ref_23_complete_365_symbol <= Xentry_354_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/simple_obj_ref_23_complete
        array_obj_ref_25_index_resize_0_366: Block -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_index_resize_0 
          signal array_obj_ref_25_index_resize_0_366_start: Boolean;
          signal Xentry_367_symbol: Boolean;
          signal Xexit_368_symbol: Boolean;
          signal index_resize_req_369_symbol : Boolean;
          signal index_resize_ack_370_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_25_index_resize_0_366_start <= array_obj_ref_25_index_computed_0_363_symbol; -- control passed to block
          Xentry_367_symbol  <= array_obj_ref_25_index_resize_0_366_start; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_index_resize_0/$entry
          index_resize_req_369_symbol <= Xentry_367_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_index_resize_0/index_resize_req
          array_obj_ref_25_index_0_resize_req_0 <= index_resize_req_369_symbol; -- link to DP
          index_resize_ack_370_symbol <= array_obj_ref_25_index_0_resize_ack_0; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_index_resize_0/index_resize_ack
          Xexit_368_symbol <= index_resize_ack_370_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_index_resize_0/$exit
          array_obj_ref_25_index_resize_0_366_symbol <= Xexit_368_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_index_resize_0
        array_obj_ref_25_index_scale_0_371: Block -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_index_scale_0 
          signal array_obj_ref_25_index_scale_0_371_start: Boolean;
          signal Xentry_372_symbol: Boolean;
          signal Xexit_373_symbol: Boolean;
          signal scale_rr_374_symbol : Boolean;
          signal scale_ra_375_symbol : Boolean;
          signal scale_cr_376_symbol : Boolean;
          signal scale_ca_377_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_25_index_scale_0_371_start <= array_obj_ref_25_index_resized_0_364_symbol; -- control passed to block
          Xentry_372_symbol  <= array_obj_ref_25_index_scale_0_371_start; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_index_scale_0/$entry
          scale_rr_374_symbol <= Xentry_372_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_index_scale_0/scale_rr
          array_obj_ref_25_index_0_scale_req_0 <= scale_rr_374_symbol; -- link to DP
          scale_ra_375_symbol <= array_obj_ref_25_index_0_scale_ack_0; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_index_scale_0/scale_ra
          scale_cr_376_symbol <= scale_ra_375_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_index_scale_0/scale_cr
          array_obj_ref_25_index_0_scale_req_1 <= scale_cr_376_symbol; -- link to DP
          scale_ca_377_symbol <= array_obj_ref_25_index_0_scale_ack_1; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_index_scale_0/scale_ca
          Xexit_373_symbol <= scale_ca_377_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_index_scale_0/$exit
          array_obj_ref_25_index_scale_0_371_symbol <= Xexit_373_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_index_scale_0
        array_obj_ref_25_add_indices_378: Block -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_add_indices 
          signal array_obj_ref_25_add_indices_378_start: Boolean;
          signal Xentry_379_symbol: Boolean;
          signal Xexit_380_symbol: Boolean;
          signal partial_sum_1_rr_381_symbol : Boolean;
          signal partial_sum_1_ra_382_symbol : Boolean;
          signal partial_sum_1_cr_383_symbol : Boolean;
          signal partial_sum_1_ca_384_symbol : Boolean;
          signal final_index_req_385_symbol : Boolean;
          signal final_index_ack_386_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_25_add_indices_378_start <= array_obj_ref_25_indices_scaled_361_symbol; -- control passed to block
          Xentry_379_symbol  <= array_obj_ref_25_add_indices_378_start; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_add_indices/$entry
          partial_sum_1_rr_381_symbol <= Xentry_379_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_add_indices/partial_sum_1_rr
          array_obj_ref_25_index_sum_1_req_0 <= partial_sum_1_rr_381_symbol; -- link to DP
          partial_sum_1_ra_382_symbol <= array_obj_ref_25_index_sum_1_ack_0; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_add_indices/partial_sum_1_ra
          partial_sum_1_cr_383_symbol <= partial_sum_1_ra_382_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_add_indices/partial_sum_1_cr
          array_obj_ref_25_index_sum_1_req_1 <= partial_sum_1_cr_383_symbol; -- link to DP
          partial_sum_1_ca_384_symbol <= array_obj_ref_25_index_sum_1_ack_1; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_add_indices/partial_sum_1_ca
          final_index_req_385_symbol <= partial_sum_1_ca_384_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_add_indices/final_index_req
          array_obj_ref_25_offset_inst_req_0 <= final_index_req_385_symbol; -- link to DP
          final_index_ack_386_symbol <= array_obj_ref_25_offset_inst_ack_0; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_add_indices/final_index_ack
          Xexit_380_symbol <= final_index_ack_386_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_add_indices/$exit
          array_obj_ref_25_add_indices_378_symbol <= Xexit_380_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_add_indices
        array_obj_ref_25_base_plus_offset_387: Block -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_base_plus_offset 
          signal array_obj_ref_25_base_plus_offset_387_start: Boolean;
          signal Xentry_388_symbol: Boolean;
          signal Xexit_389_symbol: Boolean;
          signal sum_rename_req_390_symbol : Boolean;
          signal sum_rename_ack_391_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_25_base_plus_offset_387_start <= array_obj_ref_25_offset_calculated_362_symbol; -- control passed to block
          Xentry_388_symbol  <= array_obj_ref_25_base_plus_offset_387_start; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_base_plus_offset/$entry
          sum_rename_req_390_symbol <= Xentry_388_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_base_plus_offset/sum_rename_req
          array_obj_ref_25_root_address_inst_req_0 <= sum_rename_req_390_symbol; -- link to DP
          sum_rename_ack_391_symbol <= array_obj_ref_25_root_address_inst_ack_0; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_base_plus_offset/sum_rename_ack
          Xexit_389_symbol <= sum_rename_ack_391_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_base_plus_offset/$exit
          array_obj_ref_25_base_plus_offset_387_symbol <= Xexit_389_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_25_base_plus_offset
        addr_of_26_complete_392: Block -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_26_complete 
          signal addr_of_26_complete_392_start: Boolean;
          signal Xentry_393_symbol: Boolean;
          signal Xexit_394_symbol: Boolean;
          signal final_reg_req_395_symbol : Boolean;
          signal final_reg_ack_396_symbol : Boolean;
          -- 
        begin -- 
          addr_of_26_complete_392_start <= addr_of_26_active_x_x358_symbol; -- control passed to block
          Xentry_393_symbol  <= addr_of_26_complete_392_start; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_26_complete/$entry
          final_reg_req_395_symbol <= Xentry_393_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_26_complete/final_reg_req
          addr_of_26_final_reg_req_0 <= final_reg_req_395_symbol; -- link to DP
          final_reg_ack_396_symbol <= addr_of_26_final_reg_ack_0; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_26_complete/final_reg_ack
          Xexit_394_symbol <= final_reg_ack_396_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_26_complete/$exit
          addr_of_26_complete_392_symbol <= Xexit_394_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_26_complete
        assign_stmt_33_active_x_x397_symbol <= addr_of_32_complete_433_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/assign_stmt_33_active_
        assign_stmt_33_completed_x_x398_symbol <= assign_stmt_33_active_x_x397_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/assign_stmt_33_completed_
        addr_of_32_active_x_x399_block : Block -- non-trivial join transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_32_active_ 
          signal addr_of_32_active_x_x399_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          addr_of_32_active_x_x399_predecessors(0) <= addr_of_32_trigger_x_x400_symbol;
          addr_of_32_active_x_x399_predecessors(1) <= array_obj_ref_31_root_address_calculated_401_symbol;
          addr_of_32_active_x_x399_join: join -- 
            port map( -- 
              preds => addr_of_32_active_x_x399_predecessors,
              symbol_out => addr_of_32_active_x_x399_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_32_active_
        addr_of_32_trigger_x_x400_symbol <= Xentry_354_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_32_trigger_
        array_obj_ref_31_root_address_calculated_401_symbol <= array_obj_ref_31_base_plus_offset_428_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_root_address_calculated
        array_obj_ref_31_indices_scaled_402_symbol <= array_obj_ref_31_index_scale_0_412_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_indices_scaled
        array_obj_ref_31_offset_calculated_403_symbol <= array_obj_ref_31_add_indices_419_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_offset_calculated
        array_obj_ref_31_index_computed_0_404_symbol <= simple_obj_ref_29_complete_406_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_index_computed_0
        array_obj_ref_31_index_resized_0_405_symbol <= array_obj_ref_31_index_resize_0_407_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_index_resized_0
        simple_obj_ref_29_complete_406_symbol <= Xentry_354_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/simple_obj_ref_29_complete
        array_obj_ref_31_index_resize_0_407: Block -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_index_resize_0 
          signal array_obj_ref_31_index_resize_0_407_start: Boolean;
          signal Xentry_408_symbol: Boolean;
          signal Xexit_409_symbol: Boolean;
          signal index_resize_req_410_symbol : Boolean;
          signal index_resize_ack_411_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_31_index_resize_0_407_start <= array_obj_ref_31_index_computed_0_404_symbol; -- control passed to block
          Xentry_408_symbol  <= array_obj_ref_31_index_resize_0_407_start; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_index_resize_0/$entry
          index_resize_req_410_symbol <= Xentry_408_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_index_resize_0/index_resize_req
          array_obj_ref_31_index_0_resize_req_0 <= index_resize_req_410_symbol; -- link to DP
          index_resize_ack_411_symbol <= array_obj_ref_31_index_0_resize_ack_0; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_index_resize_0/index_resize_ack
          Xexit_409_symbol <= index_resize_ack_411_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_index_resize_0/$exit
          array_obj_ref_31_index_resize_0_407_symbol <= Xexit_409_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_index_resize_0
        array_obj_ref_31_index_scale_0_412: Block -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_index_scale_0 
          signal array_obj_ref_31_index_scale_0_412_start: Boolean;
          signal Xentry_413_symbol: Boolean;
          signal Xexit_414_symbol: Boolean;
          signal scale_rr_415_symbol : Boolean;
          signal scale_ra_416_symbol : Boolean;
          signal scale_cr_417_symbol : Boolean;
          signal scale_ca_418_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_31_index_scale_0_412_start <= array_obj_ref_31_index_resized_0_405_symbol; -- control passed to block
          Xentry_413_symbol  <= array_obj_ref_31_index_scale_0_412_start; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_index_scale_0/$entry
          scale_rr_415_symbol <= Xentry_413_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_index_scale_0/scale_rr
          array_obj_ref_31_index_0_scale_req_0 <= scale_rr_415_symbol; -- link to DP
          scale_ra_416_symbol <= array_obj_ref_31_index_0_scale_ack_0; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_index_scale_0/scale_ra
          scale_cr_417_symbol <= scale_ra_416_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_index_scale_0/scale_cr
          array_obj_ref_31_index_0_scale_req_1 <= scale_cr_417_symbol; -- link to DP
          scale_ca_418_symbol <= array_obj_ref_31_index_0_scale_ack_1; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_index_scale_0/scale_ca
          Xexit_414_symbol <= scale_ca_418_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_index_scale_0/$exit
          array_obj_ref_31_index_scale_0_412_symbol <= Xexit_414_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_index_scale_0
        array_obj_ref_31_add_indices_419: Block -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_add_indices 
          signal array_obj_ref_31_add_indices_419_start: Boolean;
          signal Xentry_420_symbol: Boolean;
          signal Xexit_421_symbol: Boolean;
          signal partial_sum_1_rr_422_symbol : Boolean;
          signal partial_sum_1_ra_423_symbol : Boolean;
          signal partial_sum_1_cr_424_symbol : Boolean;
          signal partial_sum_1_ca_425_symbol : Boolean;
          signal final_index_req_426_symbol : Boolean;
          signal final_index_ack_427_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_31_add_indices_419_start <= array_obj_ref_31_indices_scaled_402_symbol; -- control passed to block
          Xentry_420_symbol  <= array_obj_ref_31_add_indices_419_start; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_add_indices/$entry
          partial_sum_1_rr_422_symbol <= Xentry_420_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_add_indices/partial_sum_1_rr
          array_obj_ref_31_index_sum_1_req_0 <= partial_sum_1_rr_422_symbol; -- link to DP
          partial_sum_1_ra_423_symbol <= array_obj_ref_31_index_sum_1_ack_0; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_add_indices/partial_sum_1_ra
          partial_sum_1_cr_424_symbol <= partial_sum_1_ra_423_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_add_indices/partial_sum_1_cr
          array_obj_ref_31_index_sum_1_req_1 <= partial_sum_1_cr_424_symbol; -- link to DP
          partial_sum_1_ca_425_symbol <= array_obj_ref_31_index_sum_1_ack_1; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_add_indices/partial_sum_1_ca
          final_index_req_426_symbol <= partial_sum_1_ca_425_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_add_indices/final_index_req
          array_obj_ref_31_offset_inst_req_0 <= final_index_req_426_symbol; -- link to DP
          final_index_ack_427_symbol <= array_obj_ref_31_offset_inst_ack_0; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_add_indices/final_index_ack
          Xexit_421_symbol <= final_index_ack_427_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_add_indices/$exit
          array_obj_ref_31_add_indices_419_symbol <= Xexit_421_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_add_indices
        array_obj_ref_31_base_plus_offset_428: Block -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_base_plus_offset 
          signal array_obj_ref_31_base_plus_offset_428_start: Boolean;
          signal Xentry_429_symbol: Boolean;
          signal Xexit_430_symbol: Boolean;
          signal sum_rename_req_431_symbol : Boolean;
          signal sum_rename_ack_432_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_31_base_plus_offset_428_start <= array_obj_ref_31_offset_calculated_403_symbol; -- control passed to block
          Xentry_429_symbol  <= array_obj_ref_31_base_plus_offset_428_start; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_base_plus_offset/$entry
          sum_rename_req_431_symbol <= Xentry_429_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_base_plus_offset/sum_rename_req
          array_obj_ref_31_root_address_inst_req_0 <= sum_rename_req_431_symbol; -- link to DP
          sum_rename_ack_432_symbol <= array_obj_ref_31_root_address_inst_ack_0; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_base_plus_offset/sum_rename_ack
          Xexit_430_symbol <= sum_rename_ack_432_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_base_plus_offset/$exit
          array_obj_ref_31_base_plus_offset_428_symbol <= Xexit_430_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/array_obj_ref_31_base_plus_offset
        addr_of_32_complete_433: Block -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_32_complete 
          signal addr_of_32_complete_433_start: Boolean;
          signal Xentry_434_symbol: Boolean;
          signal Xexit_435_symbol: Boolean;
          signal final_reg_req_436_symbol : Boolean;
          signal final_reg_ack_437_symbol : Boolean;
          -- 
        begin -- 
          addr_of_32_complete_433_start <= addr_of_32_active_x_x399_symbol; -- control passed to block
          Xentry_434_symbol  <= addr_of_32_complete_433_start; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_32_complete/$entry
          final_reg_req_436_symbol <= Xentry_434_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_32_complete/final_reg_req
          addr_of_32_final_reg_req_0 <= final_reg_req_436_symbol; -- link to DP
          final_reg_ack_437_symbol <= addr_of_32_final_reg_ack_0; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_32_complete/final_reg_ack
          Xexit_435_symbol <= final_reg_ack_437_symbol; -- transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_32_complete/$exit
          addr_of_32_complete_433_symbol <= Xexit_435_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/addr_of_32_complete
        Xexit_355_block : Block -- non-trivial join transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/$exit 
          signal Xexit_355_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_355_predecessors(0) <= assign_stmt_27_completed_x_x357_symbol;
          Xexit_355_predecessors(1) <= assign_stmt_33_completed_x_x398_symbol;
          Xexit_355_join: join -- 
            port map( -- 
              preds => Xexit_355_predecessors,
              symbol_out => Xexit_355_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33/$exit
        assign_stmt_27_to_assign_stmt_33_353_symbol <= Xexit_355_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_16/assign_stmt_27_to_assign_stmt_33
      call_stmt_37_438: Block -- branch_block_stmt_16/call_stmt_37 
        signal call_stmt_37_438_start: Boolean;
        signal Xentry_439_symbol: Boolean;
        signal Xexit_440_symbol: Boolean;
        signal simple_obj_ref_34_complete_441_symbol : Boolean;
        signal simple_obj_ref_35_complete_442_symbol : Boolean;
        signal call_stmt_37_active_x_x443_symbol : Boolean;
        signal call_stmt_37_in_progress_444_symbol : Boolean;
        signal call_stmt_37_start_445_symbol : Boolean;
        signal call_stmt_37_complete_450_symbol : Boolean;
        signal call_stmt_37_call_complete_455_symbol : Boolean;
        signal call_stmt_37_completed_x_x456_symbol : Boolean;
        -- 
      begin -- 
        call_stmt_37_438_start <= call_stmt_37_x_xentry_x_xx_x337_symbol; -- control passed to block
        Xentry_439_symbol  <= call_stmt_37_438_start; -- transition branch_block_stmt_16/call_stmt_37/$entry
        simple_obj_ref_34_complete_441_symbol <= Xentry_439_symbol; -- transition branch_block_stmt_16/call_stmt_37/simple_obj_ref_34_complete
        simple_obj_ref_35_complete_442_symbol <= Xentry_439_symbol; -- transition branch_block_stmt_16/call_stmt_37/simple_obj_ref_35_complete
        call_stmt_37_active_x_x443_block : Block -- non-trivial join transition branch_block_stmt_16/call_stmt_37/call_stmt_37_active_ 
          signal call_stmt_37_active_x_x443_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          call_stmt_37_active_x_x443_predecessors(0) <= simple_obj_ref_34_complete_441_symbol;
          call_stmt_37_active_x_x443_predecessors(1) <= simple_obj_ref_35_complete_442_symbol;
          call_stmt_37_active_x_x443_join: join -- 
            port map( -- 
              preds => call_stmt_37_active_x_x443_predecessors,
              symbol_out => call_stmt_37_active_x_x443_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_16/call_stmt_37/call_stmt_37_active_
        call_stmt_37_in_progress_444_symbol <= call_stmt_37_start_445_symbol; -- transition branch_block_stmt_16/call_stmt_37/call_stmt_37_in_progress
        call_stmt_37_start_445: Block -- branch_block_stmt_16/call_stmt_37/call_stmt_37_start 
          signal call_stmt_37_start_445_start: Boolean;
          signal Xentry_446_symbol: Boolean;
          signal Xexit_447_symbol: Boolean;
          signal crr_448_symbol : Boolean;
          signal cra_449_symbol : Boolean;
          -- 
        begin -- 
          call_stmt_37_start_445_start <= call_stmt_37_active_x_x443_symbol; -- control passed to block
          Xentry_446_symbol  <= call_stmt_37_start_445_start; -- transition branch_block_stmt_16/call_stmt_37/call_stmt_37_start/$entry
          crr_448_symbol <= Xentry_446_symbol; -- transition branch_block_stmt_16/call_stmt_37/call_stmt_37_start/crr
          call_stmt_37_call_req_0 <= crr_448_symbol; -- link to DP
          cra_449_symbol <= call_stmt_37_call_ack_0; -- transition branch_block_stmt_16/call_stmt_37/call_stmt_37_start/cra
          Xexit_447_symbol <= cra_449_symbol; -- transition branch_block_stmt_16/call_stmt_37/call_stmt_37_start/$exit
          call_stmt_37_start_445_symbol <= Xexit_447_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_16/call_stmt_37/call_stmt_37_start
        call_stmt_37_complete_450: Block -- branch_block_stmt_16/call_stmt_37/call_stmt_37_complete 
          signal call_stmt_37_complete_450_start: Boolean;
          signal Xentry_451_symbol: Boolean;
          signal Xexit_452_symbol: Boolean;
          signal ccr_453_symbol : Boolean;
          signal cca_454_symbol : Boolean;
          -- 
        begin -- 
          call_stmt_37_complete_450_start <= call_stmt_37_in_progress_444_symbol; -- control passed to block
          Xentry_451_symbol  <= call_stmt_37_complete_450_start; -- transition branch_block_stmt_16/call_stmt_37/call_stmt_37_complete/$entry
          ccr_453_symbol <= Xentry_451_symbol; -- transition branch_block_stmt_16/call_stmt_37/call_stmt_37_complete/ccr
          call_stmt_37_call_req_1 <= ccr_453_symbol; -- link to DP
          cca_454_symbol <= call_stmt_37_call_ack_1; -- transition branch_block_stmt_16/call_stmt_37/call_stmt_37_complete/cca
          Xexit_452_symbol <= cca_454_symbol; -- transition branch_block_stmt_16/call_stmt_37/call_stmt_37_complete/$exit
          call_stmt_37_complete_450_symbol <= Xexit_452_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_16/call_stmt_37/call_stmt_37_complete
        call_stmt_37_call_complete_455_symbol <= call_stmt_37_complete_450_symbol; -- transition branch_block_stmt_16/call_stmt_37/call_stmt_37_call_complete
        call_stmt_37_completed_x_x456_symbol <= call_stmt_37_call_complete_455_symbol; -- transition branch_block_stmt_16/call_stmt_37/call_stmt_37_completed_
        Xexit_440_symbol <= call_stmt_37_completed_x_x456_symbol; -- transition branch_block_stmt_16/call_stmt_37/$exit
        call_stmt_37_438_symbol <= Xexit_440_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_16/call_stmt_37
      assign_stmt_40_457: Block -- branch_block_stmt_16/assign_stmt_40 
        signal assign_stmt_40_457_start: Boolean;
        signal Xentry_458_symbol: Boolean;
        signal Xexit_459_symbol: Boolean;
        signal assign_stmt_40_active_x_x460_symbol : Boolean;
        signal assign_stmt_40_completed_x_x461_symbol : Boolean;
        signal simple_obj_ref_39_complete_462_symbol : Boolean;
        signal simple_obj_ref_38_trigger_x_x463_symbol : Boolean;
        signal simple_obj_ref_38_complete_464_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_40_457_start <= assign_stmt_40_x_xentry_x_xx_x339_symbol; -- control passed to block
        Xentry_458_symbol  <= assign_stmt_40_457_start; -- transition branch_block_stmt_16/assign_stmt_40/$entry
        assign_stmt_40_active_x_x460_symbol <= simple_obj_ref_39_complete_462_symbol; -- transition branch_block_stmt_16/assign_stmt_40/assign_stmt_40_active_
        assign_stmt_40_completed_x_x461_symbol <= simple_obj_ref_38_complete_464_symbol; -- transition branch_block_stmt_16/assign_stmt_40/assign_stmt_40_completed_
        simple_obj_ref_39_complete_462_symbol <= Xentry_458_symbol; -- transition branch_block_stmt_16/assign_stmt_40/simple_obj_ref_39_complete
        simple_obj_ref_38_trigger_x_x463_symbol <= assign_stmt_40_active_x_x460_symbol; -- transition branch_block_stmt_16/assign_stmt_40/simple_obj_ref_38_trigger_
        simple_obj_ref_38_complete_464: Block -- branch_block_stmt_16/assign_stmt_40/simple_obj_ref_38_complete 
          signal simple_obj_ref_38_complete_464_start: Boolean;
          signal Xentry_465_symbol: Boolean;
          signal Xexit_466_symbol: Boolean;
          signal pipe_wreq_467_symbol : Boolean;
          signal pipe_wack_468_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_38_complete_464_start <= simple_obj_ref_38_trigger_x_x463_symbol; -- control passed to block
          Xentry_465_symbol  <= simple_obj_ref_38_complete_464_start; -- transition branch_block_stmt_16/assign_stmt_40/simple_obj_ref_38_complete/$entry
          pipe_wreq_467_symbol <= Xentry_465_symbol; -- transition branch_block_stmt_16/assign_stmt_40/simple_obj_ref_38_complete/pipe_wreq
          simple_obj_ref_38_inst_req_0 <= pipe_wreq_467_symbol; -- link to DP
          pipe_wack_468_symbol <= simple_obj_ref_38_inst_ack_0; -- transition branch_block_stmt_16/assign_stmt_40/simple_obj_ref_38_complete/pipe_wack
          Xexit_466_symbol <= pipe_wack_468_symbol; -- transition branch_block_stmt_16/assign_stmt_40/simple_obj_ref_38_complete/$exit
          simple_obj_ref_38_complete_464_symbol <= Xexit_466_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_16/assign_stmt_40/simple_obj_ref_38_complete
        Xexit_459_symbol <= assign_stmt_40_completed_x_x461_symbol; -- transition branch_block_stmt_16/assign_stmt_40/$exit
        assign_stmt_40_457_symbol <= Xexit_459_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_16/assign_stmt_40
      bb_0_bb_1_PhiReq_469: Block -- branch_block_stmt_16/bb_0_bb_1_PhiReq 
        signal bb_0_bb_1_PhiReq_469_start: Boolean;
        signal Xentry_470_symbol: Boolean;
        signal Xexit_471_symbol: Boolean;
        -- 
      begin -- 
        bb_0_bb_1_PhiReq_469_start <= bb_0_bb_1_331_symbol; -- control passed to block
        Xentry_470_symbol  <= bb_0_bb_1_PhiReq_469_start; -- transition branch_block_stmt_16/bb_0_bb_1_PhiReq/$entry
        Xexit_471_symbol <= Xentry_470_symbol; -- transition branch_block_stmt_16/bb_0_bb_1_PhiReq/$exit
        bb_0_bb_1_PhiReq_469_symbol <= Xexit_471_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_16/bb_0_bb_1_PhiReq
      bb_1_bb_1_PhiReq_472: Block -- branch_block_stmt_16/bb_1_bb_1_PhiReq 
        signal bb_1_bb_1_PhiReq_472_start: Boolean;
        signal Xentry_473_symbol: Boolean;
        signal Xexit_474_symbol: Boolean;
        -- 
      begin -- 
        bb_1_bb_1_PhiReq_472_start <= bb_1_bb_1_341_symbol; -- control passed to block
        Xentry_473_symbol  <= bb_1_bb_1_PhiReq_472_start; -- transition branch_block_stmt_16/bb_1_bb_1_PhiReq/$entry
        Xexit_474_symbol <= Xentry_473_symbol; -- transition branch_block_stmt_16/bb_1_bb_1_PhiReq/$exit
        bb_1_bb_1_PhiReq_472_symbol <= Xexit_474_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_16/bb_1_bb_1_PhiReq
      merge_stmt_18_PhiReqMerge_475_symbol  <=  bb_0_bb_1_PhiReq_469_symbol or bb_1_bb_1_PhiReq_472_symbol; -- place branch_block_stmt_16/merge_stmt_18_PhiReqMerge (optimized away) 
      merge_stmt_18_PhiAck_476: Block -- branch_block_stmt_16/merge_stmt_18_PhiAck 
        signal merge_stmt_18_PhiAck_476_start: Boolean;
        signal Xentry_477_symbol: Boolean;
        signal Xexit_478_symbol: Boolean;
        signal dummy_479_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_18_PhiAck_476_start <= merge_stmt_18_PhiReqMerge_475_symbol; -- control passed to block
        Xentry_477_symbol  <= merge_stmt_18_PhiAck_476_start; -- transition branch_block_stmt_16/merge_stmt_18_PhiAck/$entry
        dummy_479_symbol <= Xentry_477_symbol; -- transition branch_block_stmt_16/merge_stmt_18_PhiAck/dummy
        Xexit_478_symbol <= dummy_479_symbol; -- transition branch_block_stmt_16/merge_stmt_18_PhiAck/$exit
        merge_stmt_18_PhiAck_476_symbol <= Xexit_478_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_16/merge_stmt_18_PhiAck
      Xexit_328_symbol <= branch_block_stmt_16_x_xexit_x_xx_x330_symbol; -- transition branch_block_stmt_16/$exit
      branch_block_stmt_16_326_symbol <= Xexit_328_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_16
    Xexit_325_symbol <= branch_block_stmt_16_326_symbol; -- transition $exit
    fin  <=  '1' when Xexit_325_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal array_obj_ref_25_constant_part_of_offset : std_logic_vector(9 downto 0);
    signal array_obj_ref_25_final_offset : std_logic_vector(9 downto 0);
    signal array_obj_ref_25_index_partial_sum_1 : std_logic_vector(9 downto 0);
    signal array_obj_ref_25_offset_scale_factor_0 : std_logic_vector(9 downto 0);
    signal array_obj_ref_25_offset_scale_factor_1 : std_logic_vector(9 downto 0);
    signal array_obj_ref_25_resized_base_address : std_logic_vector(9 downto 0);
    signal array_obj_ref_25_root_address : std_logic_vector(9 downto 0);
    signal array_obj_ref_31_constant_part_of_offset : std_logic_vector(9 downto 0);
    signal array_obj_ref_31_final_offset : std_logic_vector(9 downto 0);
    signal array_obj_ref_31_index_partial_sum_1 : std_logic_vector(9 downto 0);
    signal array_obj_ref_31_offset_scale_factor_0 : std_logic_vector(9 downto 0);
    signal array_obj_ref_31_offset_scale_factor_1 : std_logic_vector(9 downto 0);
    signal array_obj_ref_31_resized_base_address : std_logic_vector(9 downto 0);
    signal array_obj_ref_31_root_address : std_logic_vector(9 downto 0);
    signal iNsTr_2_21 : std_logic_vector(31 downto 0);
    signal iNsTr_3_27 : std_logic_vector(31 downto 0);
    signal iNsTr_4_33 : std_logic_vector(31 downto 0);
    signal iNsTr_5_37 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_23_resized : std_logic_vector(9 downto 0);
    signal simple_obj_ref_23_scaled : std_logic_vector(9 downto 0);
    signal simple_obj_ref_29_resized : std_logic_vector(9 downto 0);
    signal simple_obj_ref_29_scaled : std_logic_vector(9 downto 0);
    -- 
  begin -- 
    array_obj_ref_25_constant_part_of_offset <= "0000000000";
    array_obj_ref_25_offset_scale_factor_0 <= "0100000000";
    array_obj_ref_25_offset_scale_factor_1 <= "0000000001";
    array_obj_ref_25_resized_base_address <= "0000000000";
    array_obj_ref_31_constant_part_of_offset <= "0000000000";
    array_obj_ref_31_offset_scale_factor_0 <= "0100000000";
    array_obj_ref_31_offset_scale_factor_1 <= "0000000001";
    array_obj_ref_31_resized_base_address <= "0000000000";
    addr_of_26_final_reg: RegisterBase --
      generic map(in_data_width => 10,out_data_width => 32, flow_through => false ) 
      port map( din => array_obj_ref_25_root_address, dout => iNsTr_3_27, req => addr_of_26_final_reg_req_0, ack => addr_of_26_final_reg_ack_0, clk => clk, reset => reset); -- 
    addr_of_32_final_reg: RegisterBase --
      generic map(in_data_width => 10,out_data_width => 32, flow_through => false ) 
      port map( din => array_obj_ref_31_root_address, dout => iNsTr_4_33, req => addr_of_32_final_reg_req_0, ack => addr_of_32_final_reg_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_25_index_0_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 10, flow_through => true ) 
      port map( din => iNsTr_2_21, dout => simple_obj_ref_23_resized, req => array_obj_ref_25_index_0_resize_req_0, ack => array_obj_ref_25_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_25_offset_inst: RegisterBase --
      generic map(in_data_width => 10,out_data_width => 10, flow_through => true ) 
      port map( din => array_obj_ref_25_index_partial_sum_1, dout => array_obj_ref_25_final_offset, req => array_obj_ref_25_offset_inst_req_0, ack => array_obj_ref_25_offset_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_31_index_0_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 10, flow_through => true ) 
      port map( din => iNsTr_2_21, dout => simple_obj_ref_29_resized, req => array_obj_ref_31_index_0_resize_req_0, ack => array_obj_ref_31_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_31_offset_inst: RegisterBase --
      generic map(in_data_width => 10,out_data_width => 10, flow_through => true ) 
      port map( din => array_obj_ref_31_index_partial_sum_1, dout => array_obj_ref_31_final_offset, req => array_obj_ref_31_offset_inst_req_0, ack => array_obj_ref_31_offset_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_25_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(9 downto 0); --
    begin -- 
      array_obj_ref_25_root_address_inst_ack_0 <= array_obj_ref_25_root_address_inst_req_0;
      aggregated_sig <= array_obj_ref_25_final_offset;
      array_obj_ref_25_root_address <= aggregated_sig(9 downto 0);
      --
    end Block;
    array_obj_ref_31_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(9 downto 0); --
    begin -- 
      array_obj_ref_31_root_address_inst_ack_0 <= array_obj_ref_31_root_address_inst_req_0;
      aggregated_sig <= array_obj_ref_31_final_offset;
      array_obj_ref_31_root_address <= aggregated_sig(9 downto 0);
      --
    end Block;
    -- shared split operator group (0) : array_obj_ref_25_index_0_scale 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= simple_obj_ref_23_resized;
      simple_obj_ref_23_scaled <= data_out(9 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntMul",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 10,
          constant_operand => "0100000000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => array_obj_ref_25_index_0_scale_req_0,
          ackL => array_obj_ref_25_index_0_scale_ack_0,
          reqR => array_obj_ref_25_index_0_scale_req_1,
          ackR => array_obj_ref_25_index_0_scale_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : array_obj_ref_25_index_sum_1 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= simple_obj_ref_23_scaled;
      array_obj_ref_25_index_partial_sum_1 <= data_out(9 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 10,
          constant_operand => "0000000000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => array_obj_ref_25_index_sum_1_req_0,
          ackL => array_obj_ref_25_index_sum_1_ack_0,
          reqR => array_obj_ref_25_index_sum_1_req_1,
          ackR => array_obj_ref_25_index_sum_1_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : array_obj_ref_31_index_0_scale 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= simple_obj_ref_29_resized;
      simple_obj_ref_29_scaled <= data_out(9 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntMul",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 10,
          constant_operand => "0100000000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => array_obj_ref_31_index_0_scale_req_0,
          ackL => array_obj_ref_31_index_0_scale_ack_0,
          reqR => array_obj_ref_31_index_0_scale_req_1,
          ackR => array_obj_ref_31_index_0_scale_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : array_obj_ref_31_index_sum_1 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= simple_obj_ref_29_scaled;
      array_obj_ref_31_index_partial_sum_1 <= data_out(9 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 10,
          constant_operand => "0000000000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => array_obj_ref_31_index_sum_1_req_0,
          ackL => array_obj_ref_31_index_sum_1_ack_0,
          reqR => array_obj_ref_31_index_sum_1_req_1,
          ackR => array_obj_ref_31_index_sum_1_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared inport operator group (0) : simple_obj_ref_20_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_20_inst_req_0;
      simple_obj_ref_20_inst_ack_0 <= ack(0);
      iNsTr_2_21 <= data_out(31 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => true)
        port map (-- 
          req => req , 
          ack => ack , 
          data => data_out, 
          oreq => free_index_pipe_pipe_read_req(0),
          oack => free_index_pipe_pipe_read_ack(0),
          odata => free_index_pipe_pipe_read_data(31 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared outport operator group (0) : simple_obj_ref_38_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_38_inst_req_0;
      simple_obj_ref_38_inst_ack_0 <= ack(0);
      data_in <= iNsTr_5_37;
      outport: OutputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => true)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => send_msg_pipe_write_req(0),
          oack => send_msg_pipe_write_ack(0),
          odata => send_msg_pipe_write_data(31 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    -- shared call operator group (0) : call_stmt_37_call 
    CallGroup0: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= call_stmt_37_call_req_0;
      call_stmt_37_call_ack_0 <= ackL(0);
      reqR(0) <= call_stmt_37_call_req_1;
      call_stmt_37_call_ack_1 <= ackR(0);
      data_in <= iNsTr_3_27 & iNsTr_4_33;
      iNsTr_5_37 <= data_out(31 downto 0);
      CallReq: InputMuxBase -- 
        generic map (  iwidth => 64, owidth => 64, twidth => 1, nreqs => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          reqR => store_packet_call_reqs(0),
          ackR => store_packet_call_acks(0),
          dataR => store_packet_call_data(63 downto 0),
          tagR => store_packet_call_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      CallComplete: OutputDemuxBase -- 
        generic map ( 
        iwidth => 32, owidth => 32, twidth => 1, nreqs => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          reqL => store_packet_return_acks(0), -- cross-over
          ackL => store_packet_return_reqs(0), -- cross-over
          dataL => store_packet_return_data(31 downto 0),
          tagL => store_packet_return_tag(0 downto 0),
          clk => clk,
          reset => reset -- 
        ); -- 
      -- 
    end Block; -- call group 0
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
entity remove_packet is -- 
  port ( -- 
    ctrlptr : in  std_logic_vector(31 downto 0);
    dataptr : in  std_logic_vector(31 downto 0);
    pktlength : in  std_logic_vector(31 downto 0);
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    memory_space_1_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_1_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_lr_addr : out  std_logic_vector(9 downto 0);
    memory_space_1_lr_tag :  out  std_logic_vector(0 downto 0);
    memory_space_1_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_1_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_lc_data : in   std_logic_vector(7 downto 0);
    memory_space_1_lc_tag :  in  std_logic_vector(0 downto 0);
    memory_space_2_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_2_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_lr_addr : out  std_logic_vector(9 downto 0);
    memory_space_2_lr_tag :  out  std_logic_vector(0 downto 0);
    memory_space_2_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_2_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_lc_data : in   std_logic_vector(63 downto 0);
    memory_space_2_lc_tag :  in  std_logic_vector(0 downto 0);
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
end entity remove_packet;
architecture Default of remove_packet is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal array_obj_ref_168_index_0_resize_req_0 : boolean;
  signal array_obj_ref_168_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_168_index_0_rename_req_0 : boolean;
  signal array_obj_ref_168_index_0_rename_ack_0 : boolean;
  signal array_obj_ref_168_offset_inst_req_0 : boolean;
  signal array_obj_ref_168_offset_inst_ack_0 : boolean;
  signal array_obj_ref_168_base_resize_req_0 : boolean;
  signal array_obj_ref_168_base_resize_ack_0 : boolean;
  signal array_obj_ref_168_root_address_inst_req_0 : boolean;
  signal array_obj_ref_168_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_168_root_address_inst_req_1 : boolean;
  signal array_obj_ref_168_root_address_inst_ack_1 : boolean;
  signal array_obj_ref_168_final_reg_req_0 : boolean;
  signal array_obj_ref_168_final_reg_ack_0 : boolean;
  signal array_obj_ref_172_index_0_resize_req_0 : boolean;
  signal array_obj_ref_172_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_172_index_0_rename_req_0 : boolean;
  signal array_obj_ref_172_index_0_rename_ack_0 : boolean;
  signal array_obj_ref_172_offset_inst_req_0 : boolean;
  signal array_obj_ref_172_offset_inst_ack_0 : boolean;
  signal array_obj_ref_172_base_resize_req_0 : boolean;
  signal array_obj_ref_172_base_resize_ack_0 : boolean;
  signal array_obj_ref_172_root_address_inst_req_0 : boolean;
  signal array_obj_ref_172_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_172_root_address_inst_req_1 : boolean;
  signal array_obj_ref_172_root_address_inst_ack_1 : boolean;
  signal array_obj_ref_172_final_reg_req_0 : boolean;
  signal array_obj_ref_172_final_reg_ack_0 : boolean;
  signal binary_177_inst_req_0 : boolean;
  signal binary_177_inst_ack_0 : boolean;
  signal binary_177_inst_req_1 : boolean;
  signal binary_177_inst_ack_1 : boolean;
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
  signal simple_obj_ref_181_inst_req_0 : boolean;
  signal simple_obj_ref_181_inst_ack_0 : boolean;
  signal ptr_deref_187_base_resize_req_0 : boolean;
  signal ptr_deref_187_base_resize_ack_0 : boolean;
  signal ptr_deref_187_root_address_inst_req_0 : boolean;
  signal ptr_deref_187_root_address_inst_ack_0 : boolean;
  signal ptr_deref_187_addr_0_req_0 : boolean;
  signal ptr_deref_187_addr_0_ack_0 : boolean;
  signal ptr_deref_187_load_0_req_0 : boolean;
  signal ptr_deref_187_load_0_ack_0 : boolean;
  signal ptr_deref_187_load_0_req_1 : boolean;
  signal ptr_deref_187_load_0_ack_1 : boolean;
  signal ptr_deref_187_gather_scatter_req_0 : boolean;
  signal ptr_deref_187_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_185_inst_req_0 : boolean;
  signal simple_obj_ref_185_inst_ack_0 : boolean;
  signal binary_193_inst_req_0 : boolean;
  signal binary_193_inst_ack_0 : boolean;
  signal binary_193_inst_req_1 : boolean;
  signal binary_193_inst_ack_1 : boolean;
  signal if_stmt_190_branch_req_0 : boolean;
  signal if_stmt_190_branch_ack_1 : boolean;
  signal if_stmt_190_branch_ack_0 : boolean;
  signal phi_stmt_159_req_0 : boolean;
  signal phi_stmt_159_req_1 : boolean;
  signal phi_stmt_159_ack_0 : boolean;
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
  remove_packet_CP_480: Block -- control-path 
    signal remove_packet_CP_480_start: Boolean;
    signal Xentry_481_symbol: Boolean;
    signal Xexit_482_symbol: Boolean;
    signal branch_block_stmt_157_483_symbol : Boolean;
    -- 
  begin -- 
    remove_packet_CP_480_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_481_symbol  <= remove_packet_CP_480_start; -- transition $entry
    branch_block_stmt_157_483: Block -- branch_block_stmt_157 
      signal branch_block_stmt_157_483_start: Boolean;
      signal Xentry_484_symbol: Boolean;
      signal Xexit_485_symbol: Boolean;
      signal branch_block_stmt_157_x_xentry_x_xx_x486_symbol : Boolean;
      signal branch_block_stmt_157_x_xexit_x_xx_x487_symbol : Boolean;
      signal merge_stmt_158_x_xentry_x_xx_x488_symbol : Boolean;
      signal merge_stmt_158_x_xexit_x_xx_x489_symbol : Boolean;
      signal parallel_block_stmt_165_x_xentry_x_xx_x490_symbol : Boolean;
      signal parallel_block_stmt_165_x_xexit_x_xx_x491_symbol : Boolean;
      signal parallel_block_stmt_180_x_xentry_x_xx_x492_symbol : Boolean;
      signal parallel_block_stmt_180_x_xexit_x_xx_x493_symbol : Boolean;
      signal if_stmt_190_x_xentry_x_xx_x494_symbol : Boolean;
      signal if_stmt_190_x_xexit_x_xx_x495_symbol : Boolean;
      signal parallel_block_stmt_165_496_symbol : Boolean;
      signal parallel_block_stmt_180_610_symbol : Boolean;
      signal if_stmt_190_dead_link_727_symbol : Boolean;
      signal if_stmt_190_eval_test_731_symbol : Boolean;
      signal binary_193_place_745_symbol : Boolean;
      signal if_stmt_190_if_link_746_symbol : Boolean;
      signal if_stmt_190_else_link_750_symbol : Boolean;
      signal loopback_754_symbol : Boolean;
      signal if_stmt_190_else_link_to_if_stmt_190_x_xexit_x_xx_x755_symbol : Boolean;
      signal merge_stmt_158_dead_link_756_symbol : Boolean;
      signal merge_stmt_158_x_xentry_x_xx_xPhiReq_760_symbol : Boolean;
      signal loopback_PhiReq_767_symbol : Boolean;
      signal merge_stmt_158_PhiReqMerge_774_symbol : Boolean;
      signal merge_stmt_158_PhiAck_775_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_157_483_start <= Xentry_481_symbol; -- control passed to block
      Xentry_484_symbol  <= branch_block_stmt_157_483_start; -- transition branch_block_stmt_157/$entry
      branch_block_stmt_157_x_xentry_x_xx_x486_symbol  <=  Xentry_484_symbol; -- place branch_block_stmt_157/branch_block_stmt_157__entry__ (optimized away) 
      branch_block_stmt_157_x_xexit_x_xx_x487_symbol  <=  if_stmt_190_x_xexit_x_xx_x495_symbol; -- place branch_block_stmt_157/branch_block_stmt_157__exit__ (optimized away) 
      merge_stmt_158_x_xentry_x_xx_x488_symbol  <=  branch_block_stmt_157_x_xentry_x_xx_x486_symbol; -- place branch_block_stmt_157/merge_stmt_158__entry__ (optimized away) 
      merge_stmt_158_x_xexit_x_xx_x489_symbol  <=  merge_stmt_158_dead_link_756_symbol or merge_stmt_158_PhiAck_775_symbol; -- place branch_block_stmt_157/merge_stmt_158__exit__ (optimized away) 
      parallel_block_stmt_165_x_xentry_x_xx_x490_symbol  <=  merge_stmt_158_x_xexit_x_xx_x489_symbol; -- place branch_block_stmt_157/parallel_block_stmt_165__entry__ (optimized away) 
      parallel_block_stmt_165_x_xexit_x_xx_x491_symbol  <=  parallel_block_stmt_165_496_symbol; -- place branch_block_stmt_157/parallel_block_stmt_165__exit__ (optimized away) 
      parallel_block_stmt_180_x_xentry_x_xx_x492_symbol  <=  parallel_block_stmt_165_x_xexit_x_xx_x491_symbol; -- place branch_block_stmt_157/parallel_block_stmt_180__entry__ (optimized away) 
      parallel_block_stmt_180_x_xexit_x_xx_x493_symbol  <=  parallel_block_stmt_180_610_symbol; -- place branch_block_stmt_157/parallel_block_stmt_180__exit__ (optimized away) 
      if_stmt_190_x_xentry_x_xx_x494_symbol  <=  parallel_block_stmt_180_x_xexit_x_xx_x493_symbol; -- place branch_block_stmt_157/if_stmt_190__entry__ (optimized away) 
      if_stmt_190_x_xexit_x_xx_x495_symbol  <=  if_stmt_190_else_link_to_if_stmt_190_x_xexit_x_xx_x755_symbol or if_stmt_190_dead_link_727_symbol; -- place branch_block_stmt_157/if_stmt_190__exit__ (optimized away) 
      parallel_block_stmt_165_496: Block -- branch_block_stmt_157/parallel_block_stmt_165 
        signal parallel_block_stmt_165_496_start: Boolean;
        signal Xentry_497_symbol: Boolean;
        signal Xexit_498_symbol: Boolean;
        signal assign_stmt_169_499_symbol : Boolean;
        signal assign_stmt_173_547_symbol : Boolean;
        signal assign_stmt_178_595_symbol : Boolean;
        -- 
      begin -- 
        parallel_block_stmt_165_496_start <= parallel_block_stmt_165_x_xentry_x_xx_x490_symbol; -- control passed to block
        Xentry_497_symbol  <= parallel_block_stmt_165_496_start; -- transition branch_block_stmt_157/parallel_block_stmt_165/$entry
        assign_stmt_169_499: Block -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169 
          signal assign_stmt_169_499_start: Boolean;
          signal Xentry_500_symbol: Boolean;
          signal Xexit_501_symbol: Boolean;
          signal assign_stmt_169_active_x_x502_symbol : Boolean;
          signal assign_stmt_169_completed_x_x503_symbol : Boolean;
          signal array_obj_ref_168_trigger_x_x504_symbol : Boolean;
          signal array_obj_ref_168_active_x_x505_symbol : Boolean;
          signal array_obj_ref_168_base_address_calculated_506_symbol : Boolean;
          signal array_obj_ref_168_root_address_calculated_507_symbol : Boolean;
          signal array_obj_ref_168_indices_scaled_508_symbol : Boolean;
          signal array_obj_ref_168_offset_calculated_509_symbol : Boolean;
          signal array_obj_ref_168_index_computed_0_510_symbol : Boolean;
          signal array_obj_ref_168_index_resized_0_511_symbol : Boolean;
          signal simple_obj_ref_167_complete_512_symbol : Boolean;
          signal array_obj_ref_168_index_resize_0_513_symbol : Boolean;
          signal array_obj_ref_168_index_scale_0_518_symbol : Boolean;
          signal array_obj_ref_168_add_indices_523_symbol : Boolean;
          signal array_obj_ref_168_base_address_resized_528_symbol : Boolean;
          signal array_obj_ref_168_base_addr_resize_529_symbol : Boolean;
          signal array_obj_ref_168_base_plus_offset_trigger_534_symbol : Boolean;
          signal array_obj_ref_168_base_plus_offset_535_symbol : Boolean;
          signal array_obj_ref_168_complete_542_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_169_499_start <= Xentry_497_symbol; -- control passed to block
          Xentry_500_symbol  <= assign_stmt_169_499_start; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/$entry
          assign_stmt_169_active_x_x502_symbol <= array_obj_ref_168_complete_542_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/assign_stmt_169_active_
          assign_stmt_169_completed_x_x503_symbol <= assign_stmt_169_active_x_x502_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/assign_stmt_169_completed_
          array_obj_ref_168_trigger_x_x504_symbol <= Xentry_500_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_trigger_
          array_obj_ref_168_active_x_x505_block : Block -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_active_ 
            signal array_obj_ref_168_active_x_x505_predecessors: BooleanArray(1 downto 0);
            -- 
          begin -- 
            array_obj_ref_168_active_x_x505_predecessors(0) <= array_obj_ref_168_trigger_x_x504_symbol;
            array_obj_ref_168_active_x_x505_predecessors(1) <= array_obj_ref_168_root_address_calculated_507_symbol;
            array_obj_ref_168_active_x_x505_join: join -- 
              port map( -- 
                preds => array_obj_ref_168_active_x_x505_predecessors,
                symbol_out => array_obj_ref_168_active_x_x505_symbol,
                clk => clk,
                reset => reset); -- 
            -- 
          end Block; -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_active_
          array_obj_ref_168_base_address_calculated_506_symbol <= Xentry_500_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_address_calculated
          array_obj_ref_168_root_address_calculated_507_symbol <= array_obj_ref_168_base_plus_offset_535_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_root_address_calculated
          array_obj_ref_168_indices_scaled_508_symbol <= array_obj_ref_168_index_scale_0_518_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_indices_scaled
          array_obj_ref_168_offset_calculated_509_symbol <= array_obj_ref_168_add_indices_523_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_offset_calculated
          array_obj_ref_168_index_computed_0_510_symbol <= simple_obj_ref_167_complete_512_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_index_computed_0
          array_obj_ref_168_index_resized_0_511_symbol <= array_obj_ref_168_index_resize_0_513_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_index_resized_0
          simple_obj_ref_167_complete_512_symbol <= Xentry_500_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/simple_obj_ref_167_complete
          array_obj_ref_168_index_resize_0_513: Block -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_index_resize_0 
            signal array_obj_ref_168_index_resize_0_513_start: Boolean;
            signal Xentry_514_symbol: Boolean;
            signal Xexit_515_symbol: Boolean;
            signal index_resize_req_516_symbol : Boolean;
            signal index_resize_ack_517_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_168_index_resize_0_513_start <= array_obj_ref_168_index_computed_0_510_symbol; -- control passed to block
            Xentry_514_symbol  <= array_obj_ref_168_index_resize_0_513_start; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_index_resize_0/$entry
            index_resize_req_516_symbol <= Xentry_514_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_index_resize_0/index_resize_req
            array_obj_ref_168_index_0_resize_req_0 <= index_resize_req_516_symbol; -- link to DP
            index_resize_ack_517_symbol <= array_obj_ref_168_index_0_resize_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_index_resize_0/index_resize_ack
            Xexit_515_symbol <= index_resize_ack_517_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_index_resize_0/$exit
            array_obj_ref_168_index_resize_0_513_symbol <= Xexit_515_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_index_resize_0
          array_obj_ref_168_index_scale_0_518: Block -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_index_scale_0 
            signal array_obj_ref_168_index_scale_0_518_start: Boolean;
            signal Xentry_519_symbol: Boolean;
            signal Xexit_520_symbol: Boolean;
            signal scale_rename_req_521_symbol : Boolean;
            signal scale_rename_ack_522_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_168_index_scale_0_518_start <= array_obj_ref_168_index_resized_0_511_symbol; -- control passed to block
            Xentry_519_symbol  <= array_obj_ref_168_index_scale_0_518_start; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_index_scale_0/$entry
            scale_rename_req_521_symbol <= Xentry_519_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_index_scale_0/scale_rename_req
            array_obj_ref_168_index_0_rename_req_0 <= scale_rename_req_521_symbol; -- link to DP
            scale_rename_ack_522_symbol <= array_obj_ref_168_index_0_rename_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_index_scale_0/scale_rename_ack
            Xexit_520_symbol <= scale_rename_ack_522_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_index_scale_0/$exit
            array_obj_ref_168_index_scale_0_518_symbol <= Xexit_520_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_index_scale_0
          array_obj_ref_168_add_indices_523: Block -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_add_indices 
            signal array_obj_ref_168_add_indices_523_start: Boolean;
            signal Xentry_524_symbol: Boolean;
            signal Xexit_525_symbol: Boolean;
            signal final_index_req_526_symbol : Boolean;
            signal final_index_ack_527_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_168_add_indices_523_start <= array_obj_ref_168_indices_scaled_508_symbol; -- control passed to block
            Xentry_524_symbol  <= array_obj_ref_168_add_indices_523_start; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_add_indices/$entry
            final_index_req_526_symbol <= Xentry_524_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_add_indices/final_index_req
            array_obj_ref_168_offset_inst_req_0 <= final_index_req_526_symbol; -- link to DP
            final_index_ack_527_symbol <= array_obj_ref_168_offset_inst_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_add_indices/final_index_ack
            Xexit_525_symbol <= final_index_ack_527_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_add_indices/$exit
            array_obj_ref_168_add_indices_523_symbol <= Xexit_525_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_add_indices
          array_obj_ref_168_base_address_resized_528_symbol <= array_obj_ref_168_base_addr_resize_529_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_address_resized
          array_obj_ref_168_base_addr_resize_529: Block -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_addr_resize 
            signal array_obj_ref_168_base_addr_resize_529_start: Boolean;
            signal Xentry_530_symbol: Boolean;
            signal Xexit_531_symbol: Boolean;
            signal base_resize_req_532_symbol : Boolean;
            signal base_resize_ack_533_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_168_base_addr_resize_529_start <= array_obj_ref_168_base_address_calculated_506_symbol; -- control passed to block
            Xentry_530_symbol  <= array_obj_ref_168_base_addr_resize_529_start; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_addr_resize/$entry
            base_resize_req_532_symbol <= Xentry_530_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_addr_resize/base_resize_req
            array_obj_ref_168_base_resize_req_0 <= base_resize_req_532_symbol; -- link to DP
            base_resize_ack_533_symbol <= array_obj_ref_168_base_resize_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_addr_resize/base_resize_ack
            Xexit_531_symbol <= base_resize_ack_533_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_addr_resize/$exit
            array_obj_ref_168_base_addr_resize_529_symbol <= Xexit_531_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_addr_resize
          array_obj_ref_168_base_plus_offset_trigger_534_block : Block -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_plus_offset_trigger 
            signal array_obj_ref_168_base_plus_offset_trigger_534_predecessors: BooleanArray(1 downto 0);
            -- 
          begin -- 
            array_obj_ref_168_base_plus_offset_trigger_534_predecessors(0) <= array_obj_ref_168_base_address_resized_528_symbol;
            array_obj_ref_168_base_plus_offset_trigger_534_predecessors(1) <= array_obj_ref_168_offset_calculated_509_symbol;
            array_obj_ref_168_base_plus_offset_trigger_534_join: join -- 
              port map( -- 
                preds => array_obj_ref_168_base_plus_offset_trigger_534_predecessors,
                symbol_out => array_obj_ref_168_base_plus_offset_trigger_534_symbol,
                clk => clk,
                reset => reset); -- 
            -- 
          end Block; -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_plus_offset_trigger
          array_obj_ref_168_base_plus_offset_535: Block -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_plus_offset 
            signal array_obj_ref_168_base_plus_offset_535_start: Boolean;
            signal Xentry_536_symbol: Boolean;
            signal Xexit_537_symbol: Boolean;
            signal plus_base_rr_538_symbol : Boolean;
            signal plus_base_ra_539_symbol : Boolean;
            signal plus_base_cr_540_symbol : Boolean;
            signal plus_base_ca_541_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_168_base_plus_offset_535_start <= array_obj_ref_168_base_plus_offset_trigger_534_symbol; -- control passed to block
            Xentry_536_symbol  <= array_obj_ref_168_base_plus_offset_535_start; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_plus_offset/$entry
            plus_base_rr_538_symbol <= Xentry_536_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_plus_offset/plus_base_rr
            array_obj_ref_168_root_address_inst_req_0 <= plus_base_rr_538_symbol; -- link to DP
            plus_base_ra_539_symbol <= array_obj_ref_168_root_address_inst_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_plus_offset/plus_base_ra
            plus_base_cr_540_symbol <= plus_base_ra_539_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_plus_offset/plus_base_cr
            array_obj_ref_168_root_address_inst_req_1 <= plus_base_cr_540_symbol; -- link to DP
            plus_base_ca_541_symbol <= array_obj_ref_168_root_address_inst_ack_1; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_plus_offset/plus_base_ca
            Xexit_537_symbol <= plus_base_ca_541_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_plus_offset/$exit
            array_obj_ref_168_base_plus_offset_535_symbol <= Xexit_537_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_base_plus_offset
          array_obj_ref_168_complete_542: Block -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_complete 
            signal array_obj_ref_168_complete_542_start: Boolean;
            signal Xentry_543_symbol: Boolean;
            signal Xexit_544_symbol: Boolean;
            signal final_reg_req_545_symbol : Boolean;
            signal final_reg_ack_546_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_168_complete_542_start <= array_obj_ref_168_active_x_x505_symbol; -- control passed to block
            Xentry_543_symbol  <= array_obj_ref_168_complete_542_start; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_complete/$entry
            final_reg_req_545_symbol <= Xentry_543_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_complete/final_reg_req
            array_obj_ref_168_final_reg_req_0 <= final_reg_req_545_symbol; -- link to DP
            final_reg_ack_546_symbol <= array_obj_ref_168_final_reg_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_complete/final_reg_ack
            Xexit_544_symbol <= final_reg_ack_546_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_complete/$exit
            array_obj_ref_168_complete_542_symbol <= Xexit_544_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/array_obj_ref_168_complete
          Xexit_501_symbol <= assign_stmt_169_completed_x_x503_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169/$exit
          assign_stmt_169_499_symbol <= Xexit_501_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_169
        assign_stmt_173_547: Block -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173 
          signal assign_stmt_173_547_start: Boolean;
          signal Xentry_548_symbol: Boolean;
          signal Xexit_549_symbol: Boolean;
          signal assign_stmt_173_active_x_x550_symbol : Boolean;
          signal assign_stmt_173_completed_x_x551_symbol : Boolean;
          signal array_obj_ref_172_trigger_x_x552_symbol : Boolean;
          signal array_obj_ref_172_active_x_x553_symbol : Boolean;
          signal array_obj_ref_172_base_address_calculated_554_symbol : Boolean;
          signal array_obj_ref_172_root_address_calculated_555_symbol : Boolean;
          signal array_obj_ref_172_indices_scaled_556_symbol : Boolean;
          signal array_obj_ref_172_offset_calculated_557_symbol : Boolean;
          signal array_obj_ref_172_index_computed_0_558_symbol : Boolean;
          signal array_obj_ref_172_index_resized_0_559_symbol : Boolean;
          signal simple_obj_ref_171_complete_560_symbol : Boolean;
          signal array_obj_ref_172_index_resize_0_561_symbol : Boolean;
          signal array_obj_ref_172_index_scale_0_566_symbol : Boolean;
          signal array_obj_ref_172_add_indices_571_symbol : Boolean;
          signal array_obj_ref_172_base_address_resized_576_symbol : Boolean;
          signal array_obj_ref_172_base_addr_resize_577_symbol : Boolean;
          signal array_obj_ref_172_base_plus_offset_trigger_582_symbol : Boolean;
          signal array_obj_ref_172_base_plus_offset_583_symbol : Boolean;
          signal array_obj_ref_172_complete_590_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_173_547_start <= Xentry_497_symbol; -- control passed to block
          Xentry_548_symbol  <= assign_stmt_173_547_start; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/$entry
          assign_stmt_173_active_x_x550_symbol <= array_obj_ref_172_complete_590_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/assign_stmt_173_active_
          assign_stmt_173_completed_x_x551_symbol <= assign_stmt_173_active_x_x550_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/assign_stmt_173_completed_
          array_obj_ref_172_trigger_x_x552_symbol <= Xentry_548_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_trigger_
          array_obj_ref_172_active_x_x553_block : Block -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_active_ 
            signal array_obj_ref_172_active_x_x553_predecessors: BooleanArray(1 downto 0);
            -- 
          begin -- 
            array_obj_ref_172_active_x_x553_predecessors(0) <= array_obj_ref_172_trigger_x_x552_symbol;
            array_obj_ref_172_active_x_x553_predecessors(1) <= array_obj_ref_172_root_address_calculated_555_symbol;
            array_obj_ref_172_active_x_x553_join: join -- 
              port map( -- 
                preds => array_obj_ref_172_active_x_x553_predecessors,
                symbol_out => array_obj_ref_172_active_x_x553_symbol,
                clk => clk,
                reset => reset); -- 
            -- 
          end Block; -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_active_
          array_obj_ref_172_base_address_calculated_554_symbol <= Xentry_548_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_address_calculated
          array_obj_ref_172_root_address_calculated_555_symbol <= array_obj_ref_172_base_plus_offset_583_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_root_address_calculated
          array_obj_ref_172_indices_scaled_556_symbol <= array_obj_ref_172_index_scale_0_566_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_indices_scaled
          array_obj_ref_172_offset_calculated_557_symbol <= array_obj_ref_172_add_indices_571_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_offset_calculated
          array_obj_ref_172_index_computed_0_558_symbol <= simple_obj_ref_171_complete_560_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_index_computed_0
          array_obj_ref_172_index_resized_0_559_symbol <= array_obj_ref_172_index_resize_0_561_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_index_resized_0
          simple_obj_ref_171_complete_560_symbol <= Xentry_548_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/simple_obj_ref_171_complete
          array_obj_ref_172_index_resize_0_561: Block -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_index_resize_0 
            signal array_obj_ref_172_index_resize_0_561_start: Boolean;
            signal Xentry_562_symbol: Boolean;
            signal Xexit_563_symbol: Boolean;
            signal index_resize_req_564_symbol : Boolean;
            signal index_resize_ack_565_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_172_index_resize_0_561_start <= array_obj_ref_172_index_computed_0_558_symbol; -- control passed to block
            Xentry_562_symbol  <= array_obj_ref_172_index_resize_0_561_start; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_index_resize_0/$entry
            index_resize_req_564_symbol <= Xentry_562_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_index_resize_0/index_resize_req
            array_obj_ref_172_index_0_resize_req_0 <= index_resize_req_564_symbol; -- link to DP
            index_resize_ack_565_symbol <= array_obj_ref_172_index_0_resize_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_index_resize_0/index_resize_ack
            Xexit_563_symbol <= index_resize_ack_565_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_index_resize_0/$exit
            array_obj_ref_172_index_resize_0_561_symbol <= Xexit_563_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_index_resize_0
          array_obj_ref_172_index_scale_0_566: Block -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_index_scale_0 
            signal array_obj_ref_172_index_scale_0_566_start: Boolean;
            signal Xentry_567_symbol: Boolean;
            signal Xexit_568_symbol: Boolean;
            signal scale_rename_req_569_symbol : Boolean;
            signal scale_rename_ack_570_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_172_index_scale_0_566_start <= array_obj_ref_172_index_resized_0_559_symbol; -- control passed to block
            Xentry_567_symbol  <= array_obj_ref_172_index_scale_0_566_start; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_index_scale_0/$entry
            scale_rename_req_569_symbol <= Xentry_567_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_index_scale_0/scale_rename_req
            array_obj_ref_172_index_0_rename_req_0 <= scale_rename_req_569_symbol; -- link to DP
            scale_rename_ack_570_symbol <= array_obj_ref_172_index_0_rename_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_index_scale_0/scale_rename_ack
            Xexit_568_symbol <= scale_rename_ack_570_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_index_scale_0/$exit
            array_obj_ref_172_index_scale_0_566_symbol <= Xexit_568_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_index_scale_0
          array_obj_ref_172_add_indices_571: Block -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_add_indices 
            signal array_obj_ref_172_add_indices_571_start: Boolean;
            signal Xentry_572_symbol: Boolean;
            signal Xexit_573_symbol: Boolean;
            signal final_index_req_574_symbol : Boolean;
            signal final_index_ack_575_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_172_add_indices_571_start <= array_obj_ref_172_indices_scaled_556_symbol; -- control passed to block
            Xentry_572_symbol  <= array_obj_ref_172_add_indices_571_start; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_add_indices/$entry
            final_index_req_574_symbol <= Xentry_572_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_add_indices/final_index_req
            array_obj_ref_172_offset_inst_req_0 <= final_index_req_574_symbol; -- link to DP
            final_index_ack_575_symbol <= array_obj_ref_172_offset_inst_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_add_indices/final_index_ack
            Xexit_573_symbol <= final_index_ack_575_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_add_indices/$exit
            array_obj_ref_172_add_indices_571_symbol <= Xexit_573_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_add_indices
          array_obj_ref_172_base_address_resized_576_symbol <= array_obj_ref_172_base_addr_resize_577_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_address_resized
          array_obj_ref_172_base_addr_resize_577: Block -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_addr_resize 
            signal array_obj_ref_172_base_addr_resize_577_start: Boolean;
            signal Xentry_578_symbol: Boolean;
            signal Xexit_579_symbol: Boolean;
            signal base_resize_req_580_symbol : Boolean;
            signal base_resize_ack_581_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_172_base_addr_resize_577_start <= array_obj_ref_172_base_address_calculated_554_symbol; -- control passed to block
            Xentry_578_symbol  <= array_obj_ref_172_base_addr_resize_577_start; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_addr_resize/$entry
            base_resize_req_580_symbol <= Xentry_578_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_addr_resize/base_resize_req
            array_obj_ref_172_base_resize_req_0 <= base_resize_req_580_symbol; -- link to DP
            base_resize_ack_581_symbol <= array_obj_ref_172_base_resize_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_addr_resize/base_resize_ack
            Xexit_579_symbol <= base_resize_ack_581_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_addr_resize/$exit
            array_obj_ref_172_base_addr_resize_577_symbol <= Xexit_579_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_addr_resize
          array_obj_ref_172_base_plus_offset_trigger_582_block : Block -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_plus_offset_trigger 
            signal array_obj_ref_172_base_plus_offset_trigger_582_predecessors: BooleanArray(1 downto 0);
            -- 
          begin -- 
            array_obj_ref_172_base_plus_offset_trigger_582_predecessors(0) <= array_obj_ref_172_base_address_resized_576_symbol;
            array_obj_ref_172_base_plus_offset_trigger_582_predecessors(1) <= array_obj_ref_172_offset_calculated_557_symbol;
            array_obj_ref_172_base_plus_offset_trigger_582_join: join -- 
              port map( -- 
                preds => array_obj_ref_172_base_plus_offset_trigger_582_predecessors,
                symbol_out => array_obj_ref_172_base_plus_offset_trigger_582_symbol,
                clk => clk,
                reset => reset); -- 
            -- 
          end Block; -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_plus_offset_trigger
          array_obj_ref_172_base_plus_offset_583: Block -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_plus_offset 
            signal array_obj_ref_172_base_plus_offset_583_start: Boolean;
            signal Xentry_584_symbol: Boolean;
            signal Xexit_585_symbol: Boolean;
            signal plus_base_rr_586_symbol : Boolean;
            signal plus_base_ra_587_symbol : Boolean;
            signal plus_base_cr_588_symbol : Boolean;
            signal plus_base_ca_589_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_172_base_plus_offset_583_start <= array_obj_ref_172_base_plus_offset_trigger_582_symbol; -- control passed to block
            Xentry_584_symbol  <= array_obj_ref_172_base_plus_offset_583_start; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_plus_offset/$entry
            plus_base_rr_586_symbol <= Xentry_584_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_plus_offset/plus_base_rr
            array_obj_ref_172_root_address_inst_req_0 <= plus_base_rr_586_symbol; -- link to DP
            plus_base_ra_587_symbol <= array_obj_ref_172_root_address_inst_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_plus_offset/plus_base_ra
            plus_base_cr_588_symbol <= plus_base_ra_587_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_plus_offset/plus_base_cr
            array_obj_ref_172_root_address_inst_req_1 <= plus_base_cr_588_symbol; -- link to DP
            plus_base_ca_589_symbol <= array_obj_ref_172_root_address_inst_ack_1; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_plus_offset/plus_base_ca
            Xexit_585_symbol <= plus_base_ca_589_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_plus_offset/$exit
            array_obj_ref_172_base_plus_offset_583_symbol <= Xexit_585_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_base_plus_offset
          array_obj_ref_172_complete_590: Block -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_complete 
            signal array_obj_ref_172_complete_590_start: Boolean;
            signal Xentry_591_symbol: Boolean;
            signal Xexit_592_symbol: Boolean;
            signal final_reg_req_593_symbol : Boolean;
            signal final_reg_ack_594_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_172_complete_590_start <= array_obj_ref_172_active_x_x553_symbol; -- control passed to block
            Xentry_591_symbol  <= array_obj_ref_172_complete_590_start; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_complete/$entry
            final_reg_req_593_symbol <= Xentry_591_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_complete/final_reg_req
            array_obj_ref_172_final_reg_req_0 <= final_reg_req_593_symbol; -- link to DP
            final_reg_ack_594_symbol <= array_obj_ref_172_final_reg_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_complete/final_reg_ack
            Xexit_592_symbol <= final_reg_ack_594_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_complete/$exit
            array_obj_ref_172_complete_590_symbol <= Xexit_592_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/array_obj_ref_172_complete
          Xexit_549_symbol <= assign_stmt_173_completed_x_x551_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173/$exit
          assign_stmt_173_547_symbol <= Xexit_549_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_173
        assign_stmt_178_595: Block -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178 
          signal assign_stmt_178_595_start: Boolean;
          signal Xentry_596_symbol: Boolean;
          signal Xexit_597_symbol: Boolean;
          signal assign_stmt_178_active_x_x598_symbol : Boolean;
          signal assign_stmt_178_completed_x_x599_symbol : Boolean;
          signal binary_177_active_x_x600_symbol : Boolean;
          signal binary_177_trigger_x_x601_symbol : Boolean;
          signal simple_obj_ref_175_complete_602_symbol : Boolean;
          signal binary_177_complete_603_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_178_595_start <= Xentry_497_symbol; -- control passed to block
          Xentry_596_symbol  <= assign_stmt_178_595_start; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178/$entry
          assign_stmt_178_active_x_x598_symbol <= binary_177_complete_603_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178/assign_stmt_178_active_
          assign_stmt_178_completed_x_x599_symbol <= assign_stmt_178_active_x_x598_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178/assign_stmt_178_completed_
          binary_177_active_x_x600_block : Block -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178/binary_177_active_ 
            signal binary_177_active_x_x600_predecessors: BooleanArray(1 downto 0);
            -- 
          begin -- 
            binary_177_active_x_x600_predecessors(0) <= binary_177_trigger_x_x601_symbol;
            binary_177_active_x_x600_predecessors(1) <= simple_obj_ref_175_complete_602_symbol;
            binary_177_active_x_x600_join: join -- 
              port map( -- 
                preds => binary_177_active_x_x600_predecessors,
                symbol_out => binary_177_active_x_x600_symbol,
                clk => clk,
                reset => reset); -- 
            -- 
          end Block; -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178/binary_177_active_
          binary_177_trigger_x_x601_symbol <= Xentry_596_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178/binary_177_trigger_
          simple_obj_ref_175_complete_602_symbol <= Xentry_596_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178/simple_obj_ref_175_complete
          binary_177_complete_603: Block -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178/binary_177_complete 
            signal binary_177_complete_603_start: Boolean;
            signal Xentry_604_symbol: Boolean;
            signal Xexit_605_symbol: Boolean;
            signal rr_606_symbol : Boolean;
            signal ra_607_symbol : Boolean;
            signal cr_608_symbol : Boolean;
            signal ca_609_symbol : Boolean;
            -- 
          begin -- 
            binary_177_complete_603_start <= binary_177_active_x_x600_symbol; -- control passed to block
            Xentry_604_symbol  <= binary_177_complete_603_start; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178/binary_177_complete/$entry
            rr_606_symbol <= Xentry_604_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178/binary_177_complete/rr
            binary_177_inst_req_0 <= rr_606_symbol; -- link to DP
            ra_607_symbol <= binary_177_inst_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178/binary_177_complete/ra
            cr_608_symbol <= ra_607_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178/binary_177_complete/cr
            binary_177_inst_req_1 <= cr_608_symbol; -- link to DP
            ca_609_symbol <= binary_177_inst_ack_1; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178/binary_177_complete/ca
            Xexit_605_symbol <= ca_609_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178/binary_177_complete/$exit
            binary_177_complete_603_symbol <= Xexit_605_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178/binary_177_complete
          Xexit_597_symbol <= assign_stmt_178_completed_x_x599_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178/$exit
          assign_stmt_178_595_symbol <= Xexit_597_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_157/parallel_block_stmt_165/assign_stmt_178
        Xexit_498_block : Block -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_165/$exit 
          signal Xexit_498_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          Xexit_498_predecessors(0) <= assign_stmt_169_499_symbol;
          Xexit_498_predecessors(1) <= assign_stmt_173_547_symbol;
          Xexit_498_predecessors(2) <= assign_stmt_178_595_symbol;
          Xexit_498_join: join -- 
            port map( -- 
              preds => Xexit_498_predecessors,
              symbol_out => Xexit_498_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_165/$exit
        parallel_block_stmt_165_496_symbol <= Xexit_498_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_157/parallel_block_stmt_165
      parallel_block_stmt_180_610: Block -- branch_block_stmt_157/parallel_block_stmt_180 
        signal parallel_block_stmt_180_610_start: Boolean;
        signal Xentry_611_symbol: Boolean;
        signal Xexit_612_symbol: Boolean;
        signal assign_stmt_184_613_symbol : Boolean;
        signal assign_stmt_188_670_symbol : Boolean;
        -- 
      begin -- 
        parallel_block_stmt_180_610_start <= parallel_block_stmt_180_x_xentry_x_xx_x492_symbol; -- control passed to block
        Xentry_611_symbol  <= parallel_block_stmt_180_610_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/$entry
        assign_stmt_184_613: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184 
          signal assign_stmt_184_613_start: Boolean;
          signal Xentry_614_symbol: Boolean;
          signal Xexit_615_symbol: Boolean;
          signal assign_stmt_184_active_x_x616_symbol : Boolean;
          signal assign_stmt_184_completed_x_x617_symbol : Boolean;
          signal ptr_deref_183_trigger_x_x618_symbol : Boolean;
          signal ptr_deref_183_active_x_x619_symbol : Boolean;
          signal ptr_deref_183_base_address_calculated_620_symbol : Boolean;
          signal simple_obj_ref_182_complete_621_symbol : Boolean;
          signal ptr_deref_183_root_address_calculated_622_symbol : Boolean;
          signal ptr_deref_183_word_address_calculated_623_symbol : Boolean;
          signal ptr_deref_183_base_address_resized_624_symbol : Boolean;
          signal ptr_deref_183_base_addr_resize_625_symbol : Boolean;
          signal ptr_deref_183_base_plus_offset_630_symbol : Boolean;
          signal ptr_deref_183_word_addrgen_635_symbol : Boolean;
          signal ptr_deref_183_request_640_symbol : Boolean;
          signal ptr_deref_183_complete_651_symbol : Boolean;
          signal simple_obj_ref_181_trigger_x_x664_symbol : Boolean;
          signal simple_obj_ref_181_complete_665_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_184_613_start <= Xentry_611_symbol; -- control passed to block
          Xentry_614_symbol  <= assign_stmt_184_613_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/$entry
          assign_stmt_184_active_x_x616_symbol <= ptr_deref_183_complete_651_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/assign_stmt_184_active_
          assign_stmt_184_completed_x_x617_symbol <= simple_obj_ref_181_complete_665_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/assign_stmt_184_completed_
          ptr_deref_183_trigger_x_x618_block : Block -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_trigger_ 
            signal ptr_deref_183_trigger_x_x618_predecessors: BooleanArray(1 downto 0);
            -- 
          begin -- 
            ptr_deref_183_trigger_x_x618_predecessors(0) <= ptr_deref_183_word_address_calculated_623_symbol;
            ptr_deref_183_trigger_x_x618_predecessors(1) <= ptr_deref_183_base_address_calculated_620_symbol;
            ptr_deref_183_trigger_x_x618_join: join -- 
              port map( -- 
                preds => ptr_deref_183_trigger_x_x618_predecessors,
                symbol_out => ptr_deref_183_trigger_x_x618_symbol,
                clk => clk,
                reset => reset); -- 
            -- 
          end Block; -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_trigger_
          ptr_deref_183_active_x_x619_symbol <= ptr_deref_183_request_640_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_active_
          ptr_deref_183_base_address_calculated_620_symbol <= simple_obj_ref_182_complete_621_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_base_address_calculated
          simple_obj_ref_182_complete_621_symbol <= Xentry_614_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/simple_obj_ref_182_complete
          ptr_deref_183_root_address_calculated_622_symbol <= ptr_deref_183_base_plus_offset_630_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_root_address_calculated
          ptr_deref_183_word_address_calculated_623_symbol <= ptr_deref_183_word_addrgen_635_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_word_address_calculated
          ptr_deref_183_base_address_resized_624_symbol <= ptr_deref_183_base_addr_resize_625_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_base_address_resized
          ptr_deref_183_base_addr_resize_625: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_base_addr_resize 
            signal ptr_deref_183_base_addr_resize_625_start: Boolean;
            signal Xentry_626_symbol: Boolean;
            signal Xexit_627_symbol: Boolean;
            signal base_resize_req_628_symbol : Boolean;
            signal base_resize_ack_629_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_183_base_addr_resize_625_start <= ptr_deref_183_base_address_calculated_620_symbol; -- control passed to block
            Xentry_626_symbol  <= ptr_deref_183_base_addr_resize_625_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_base_addr_resize/$entry
            base_resize_req_628_symbol <= Xentry_626_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_base_addr_resize/base_resize_req
            ptr_deref_183_base_resize_req_0 <= base_resize_req_628_symbol; -- link to DP
            base_resize_ack_629_symbol <= ptr_deref_183_base_resize_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_base_addr_resize/base_resize_ack
            Xexit_627_symbol <= base_resize_ack_629_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_base_addr_resize/$exit
            ptr_deref_183_base_addr_resize_625_symbol <= Xexit_627_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_base_addr_resize
          ptr_deref_183_base_plus_offset_630: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_base_plus_offset 
            signal ptr_deref_183_base_plus_offset_630_start: Boolean;
            signal Xentry_631_symbol: Boolean;
            signal Xexit_632_symbol: Boolean;
            signal sum_rename_req_633_symbol : Boolean;
            signal sum_rename_ack_634_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_183_base_plus_offset_630_start <= ptr_deref_183_base_address_resized_624_symbol; -- control passed to block
            Xentry_631_symbol  <= ptr_deref_183_base_plus_offset_630_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_base_plus_offset/$entry
            sum_rename_req_633_symbol <= Xentry_631_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_base_plus_offset/sum_rename_req
            ptr_deref_183_root_address_inst_req_0 <= sum_rename_req_633_symbol; -- link to DP
            sum_rename_ack_634_symbol <= ptr_deref_183_root_address_inst_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_base_plus_offset/sum_rename_ack
            Xexit_632_symbol <= sum_rename_ack_634_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_base_plus_offset/$exit
            ptr_deref_183_base_plus_offset_630_symbol <= Xexit_632_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_base_plus_offset
          ptr_deref_183_word_addrgen_635: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_word_addrgen 
            signal ptr_deref_183_word_addrgen_635_start: Boolean;
            signal Xentry_636_symbol: Boolean;
            signal Xexit_637_symbol: Boolean;
            signal root_rename_req_638_symbol : Boolean;
            signal root_rename_ack_639_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_183_word_addrgen_635_start <= ptr_deref_183_root_address_calculated_622_symbol; -- control passed to block
            Xentry_636_symbol  <= ptr_deref_183_word_addrgen_635_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_word_addrgen/$entry
            root_rename_req_638_symbol <= Xentry_636_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_word_addrgen/root_rename_req
            ptr_deref_183_addr_0_req_0 <= root_rename_req_638_symbol; -- link to DP
            root_rename_ack_639_symbol <= ptr_deref_183_addr_0_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_word_addrgen/root_rename_ack
            Xexit_637_symbol <= root_rename_ack_639_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_word_addrgen/$exit
            ptr_deref_183_word_addrgen_635_symbol <= Xexit_637_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_word_addrgen
          ptr_deref_183_request_640: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_request 
            signal ptr_deref_183_request_640_start: Boolean;
            signal Xentry_641_symbol: Boolean;
            signal Xexit_642_symbol: Boolean;
            signal word_access_643_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_183_request_640_start <= ptr_deref_183_trigger_x_x618_symbol; -- control passed to block
            Xentry_641_symbol  <= ptr_deref_183_request_640_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_request/$entry
            word_access_643: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_request/word_access 
              signal word_access_643_start: Boolean;
              signal Xentry_644_symbol: Boolean;
              signal Xexit_645_symbol: Boolean;
              signal word_access_0_646_symbol : Boolean;
              -- 
            begin -- 
              word_access_643_start <= Xentry_641_symbol; -- control passed to block
              Xentry_644_symbol  <= word_access_643_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_request/word_access/$entry
              word_access_0_646: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_request/word_access/word_access_0 
                signal word_access_0_646_start: Boolean;
                signal Xentry_647_symbol: Boolean;
                signal Xexit_648_symbol: Boolean;
                signal rr_649_symbol : Boolean;
                signal ra_650_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_646_start <= Xentry_644_symbol; -- control passed to block
                Xentry_647_symbol  <= word_access_0_646_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_request/word_access/word_access_0/$entry
                rr_649_symbol <= Xentry_647_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_request/word_access/word_access_0/rr
                ptr_deref_183_load_0_req_0 <= rr_649_symbol; -- link to DP
                ra_650_symbol <= ptr_deref_183_load_0_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_request/word_access/word_access_0/ra
                Xexit_648_symbol <= ra_650_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_request/word_access/word_access_0/$exit
                word_access_0_646_symbol <= Xexit_648_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_request/word_access/word_access_0
              Xexit_645_symbol <= word_access_0_646_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_request/word_access/$exit
              word_access_643_symbol <= Xexit_645_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_request/word_access
            Xexit_642_symbol <= word_access_643_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_request/$exit
            ptr_deref_183_request_640_symbol <= Xexit_642_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_request
          ptr_deref_183_complete_651: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_complete 
            signal ptr_deref_183_complete_651_start: Boolean;
            signal Xentry_652_symbol: Boolean;
            signal Xexit_653_symbol: Boolean;
            signal word_access_654_symbol : Boolean;
            signal merge_req_662_symbol : Boolean;
            signal merge_ack_663_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_183_complete_651_start <= ptr_deref_183_active_x_x619_symbol; -- control passed to block
            Xentry_652_symbol  <= ptr_deref_183_complete_651_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_complete/$entry
            word_access_654: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_complete/word_access 
              signal word_access_654_start: Boolean;
              signal Xentry_655_symbol: Boolean;
              signal Xexit_656_symbol: Boolean;
              signal word_access_0_657_symbol : Boolean;
              -- 
            begin -- 
              word_access_654_start <= Xentry_652_symbol; -- control passed to block
              Xentry_655_symbol  <= word_access_654_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_complete/word_access/$entry
              word_access_0_657: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_complete/word_access/word_access_0 
                signal word_access_0_657_start: Boolean;
                signal Xentry_658_symbol: Boolean;
                signal Xexit_659_symbol: Boolean;
                signal cr_660_symbol : Boolean;
                signal ca_661_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_657_start <= Xentry_655_symbol; -- control passed to block
                Xentry_658_symbol  <= word_access_0_657_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_complete/word_access/word_access_0/$entry
                cr_660_symbol <= Xentry_658_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_complete/word_access/word_access_0/cr
                ptr_deref_183_load_0_req_1 <= cr_660_symbol; -- link to DP
                ca_661_symbol <= ptr_deref_183_load_0_ack_1; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_complete/word_access/word_access_0/ca
                Xexit_659_symbol <= ca_661_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_complete/word_access/word_access_0/$exit
                word_access_0_657_symbol <= Xexit_659_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_complete/word_access/word_access_0
              Xexit_656_symbol <= word_access_0_657_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_complete/word_access/$exit
              word_access_654_symbol <= Xexit_656_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_complete/word_access
            merge_req_662_symbol <= word_access_654_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_complete/merge_req
            ptr_deref_183_gather_scatter_req_0 <= merge_req_662_symbol; -- link to DP
            merge_ack_663_symbol <= ptr_deref_183_gather_scatter_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_complete/merge_ack
            Xexit_653_symbol <= merge_ack_663_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_complete/$exit
            ptr_deref_183_complete_651_symbol <= Xexit_653_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/ptr_deref_183_complete
          simple_obj_ref_181_trigger_x_x664_symbol <= assign_stmt_184_active_x_x616_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/simple_obj_ref_181_trigger_
          simple_obj_ref_181_complete_665: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/simple_obj_ref_181_complete 
            signal simple_obj_ref_181_complete_665_start: Boolean;
            signal Xentry_666_symbol: Boolean;
            signal Xexit_667_symbol: Boolean;
            signal pipe_wreq_668_symbol : Boolean;
            signal pipe_wack_669_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_181_complete_665_start <= simple_obj_ref_181_trigger_x_x664_symbol; -- control passed to block
            Xentry_666_symbol  <= simple_obj_ref_181_complete_665_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/simple_obj_ref_181_complete/$entry
            pipe_wreq_668_symbol <= Xentry_666_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/simple_obj_ref_181_complete/pipe_wreq
            simple_obj_ref_181_inst_req_0 <= pipe_wreq_668_symbol; -- link to DP
            pipe_wack_669_symbol <= simple_obj_ref_181_inst_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/simple_obj_ref_181_complete/pipe_wack
            Xexit_667_symbol <= pipe_wack_669_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/simple_obj_ref_181_complete/$exit
            simple_obj_ref_181_complete_665_symbol <= Xexit_667_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/simple_obj_ref_181_complete
          Xexit_615_symbol <= assign_stmt_184_completed_x_x617_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184/$exit
          assign_stmt_184_613_symbol <= Xexit_615_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_184
        assign_stmt_188_670: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188 
          signal assign_stmt_188_670_start: Boolean;
          signal Xentry_671_symbol: Boolean;
          signal Xexit_672_symbol: Boolean;
          signal assign_stmt_188_active_x_x673_symbol : Boolean;
          signal assign_stmt_188_completed_x_x674_symbol : Boolean;
          signal ptr_deref_187_trigger_x_x675_symbol : Boolean;
          signal ptr_deref_187_active_x_x676_symbol : Boolean;
          signal ptr_deref_187_base_address_calculated_677_symbol : Boolean;
          signal simple_obj_ref_186_complete_678_symbol : Boolean;
          signal ptr_deref_187_root_address_calculated_679_symbol : Boolean;
          signal ptr_deref_187_word_address_calculated_680_symbol : Boolean;
          signal ptr_deref_187_base_address_resized_681_symbol : Boolean;
          signal ptr_deref_187_base_addr_resize_682_symbol : Boolean;
          signal ptr_deref_187_base_plus_offset_687_symbol : Boolean;
          signal ptr_deref_187_word_addrgen_692_symbol : Boolean;
          signal ptr_deref_187_request_697_symbol : Boolean;
          signal ptr_deref_187_complete_708_symbol : Boolean;
          signal simple_obj_ref_185_trigger_x_x721_symbol : Boolean;
          signal simple_obj_ref_185_complete_722_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_188_670_start <= Xentry_611_symbol; -- control passed to block
          Xentry_671_symbol  <= assign_stmt_188_670_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/$entry
          assign_stmt_188_active_x_x673_symbol <= ptr_deref_187_complete_708_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/assign_stmt_188_active_
          assign_stmt_188_completed_x_x674_symbol <= simple_obj_ref_185_complete_722_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/assign_stmt_188_completed_
          ptr_deref_187_trigger_x_x675_block : Block -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_trigger_ 
            signal ptr_deref_187_trigger_x_x675_predecessors: BooleanArray(1 downto 0);
            -- 
          begin -- 
            ptr_deref_187_trigger_x_x675_predecessors(0) <= ptr_deref_187_word_address_calculated_680_symbol;
            ptr_deref_187_trigger_x_x675_predecessors(1) <= ptr_deref_187_base_address_calculated_677_symbol;
            ptr_deref_187_trigger_x_x675_join: join -- 
              port map( -- 
                preds => ptr_deref_187_trigger_x_x675_predecessors,
                symbol_out => ptr_deref_187_trigger_x_x675_symbol,
                clk => clk,
                reset => reset); -- 
            -- 
          end Block; -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_trigger_
          ptr_deref_187_active_x_x676_symbol <= ptr_deref_187_request_697_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_active_
          ptr_deref_187_base_address_calculated_677_symbol <= simple_obj_ref_186_complete_678_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_base_address_calculated
          simple_obj_ref_186_complete_678_symbol <= Xentry_671_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/simple_obj_ref_186_complete
          ptr_deref_187_root_address_calculated_679_symbol <= ptr_deref_187_base_plus_offset_687_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_root_address_calculated
          ptr_deref_187_word_address_calculated_680_symbol <= ptr_deref_187_word_addrgen_692_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_word_address_calculated
          ptr_deref_187_base_address_resized_681_symbol <= ptr_deref_187_base_addr_resize_682_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_base_address_resized
          ptr_deref_187_base_addr_resize_682: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_base_addr_resize 
            signal ptr_deref_187_base_addr_resize_682_start: Boolean;
            signal Xentry_683_symbol: Boolean;
            signal Xexit_684_symbol: Boolean;
            signal base_resize_req_685_symbol : Boolean;
            signal base_resize_ack_686_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_187_base_addr_resize_682_start <= ptr_deref_187_base_address_calculated_677_symbol; -- control passed to block
            Xentry_683_symbol  <= ptr_deref_187_base_addr_resize_682_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_base_addr_resize/$entry
            base_resize_req_685_symbol <= Xentry_683_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_base_addr_resize/base_resize_req
            ptr_deref_187_base_resize_req_0 <= base_resize_req_685_symbol; -- link to DP
            base_resize_ack_686_symbol <= ptr_deref_187_base_resize_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_base_addr_resize/base_resize_ack
            Xexit_684_symbol <= base_resize_ack_686_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_base_addr_resize/$exit
            ptr_deref_187_base_addr_resize_682_symbol <= Xexit_684_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_base_addr_resize
          ptr_deref_187_base_plus_offset_687: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_base_plus_offset 
            signal ptr_deref_187_base_plus_offset_687_start: Boolean;
            signal Xentry_688_symbol: Boolean;
            signal Xexit_689_symbol: Boolean;
            signal sum_rename_req_690_symbol : Boolean;
            signal sum_rename_ack_691_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_187_base_plus_offset_687_start <= ptr_deref_187_base_address_resized_681_symbol; -- control passed to block
            Xentry_688_symbol  <= ptr_deref_187_base_plus_offset_687_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_base_plus_offset/$entry
            sum_rename_req_690_symbol <= Xentry_688_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_base_plus_offset/sum_rename_req
            ptr_deref_187_root_address_inst_req_0 <= sum_rename_req_690_symbol; -- link to DP
            sum_rename_ack_691_symbol <= ptr_deref_187_root_address_inst_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_base_plus_offset/sum_rename_ack
            Xexit_689_symbol <= sum_rename_ack_691_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_base_plus_offset/$exit
            ptr_deref_187_base_plus_offset_687_symbol <= Xexit_689_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_base_plus_offset
          ptr_deref_187_word_addrgen_692: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_word_addrgen 
            signal ptr_deref_187_word_addrgen_692_start: Boolean;
            signal Xentry_693_symbol: Boolean;
            signal Xexit_694_symbol: Boolean;
            signal root_rename_req_695_symbol : Boolean;
            signal root_rename_ack_696_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_187_word_addrgen_692_start <= ptr_deref_187_root_address_calculated_679_symbol; -- control passed to block
            Xentry_693_symbol  <= ptr_deref_187_word_addrgen_692_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_word_addrgen/$entry
            root_rename_req_695_symbol <= Xentry_693_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_word_addrgen/root_rename_req
            ptr_deref_187_addr_0_req_0 <= root_rename_req_695_symbol; -- link to DP
            root_rename_ack_696_symbol <= ptr_deref_187_addr_0_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_word_addrgen/root_rename_ack
            Xexit_694_symbol <= root_rename_ack_696_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_word_addrgen/$exit
            ptr_deref_187_word_addrgen_692_symbol <= Xexit_694_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_word_addrgen
          ptr_deref_187_request_697: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_request 
            signal ptr_deref_187_request_697_start: Boolean;
            signal Xentry_698_symbol: Boolean;
            signal Xexit_699_symbol: Boolean;
            signal word_access_700_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_187_request_697_start <= ptr_deref_187_trigger_x_x675_symbol; -- control passed to block
            Xentry_698_symbol  <= ptr_deref_187_request_697_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_request/$entry
            word_access_700: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_request/word_access 
              signal word_access_700_start: Boolean;
              signal Xentry_701_symbol: Boolean;
              signal Xexit_702_symbol: Boolean;
              signal word_access_0_703_symbol : Boolean;
              -- 
            begin -- 
              word_access_700_start <= Xentry_698_symbol; -- control passed to block
              Xentry_701_symbol  <= word_access_700_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_request/word_access/$entry
              word_access_0_703: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_request/word_access/word_access_0 
                signal word_access_0_703_start: Boolean;
                signal Xentry_704_symbol: Boolean;
                signal Xexit_705_symbol: Boolean;
                signal rr_706_symbol : Boolean;
                signal ra_707_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_703_start <= Xentry_701_symbol; -- control passed to block
                Xentry_704_symbol  <= word_access_0_703_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_request/word_access/word_access_0/$entry
                rr_706_symbol <= Xentry_704_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_request/word_access/word_access_0/rr
                ptr_deref_187_load_0_req_0 <= rr_706_symbol; -- link to DP
                ra_707_symbol <= ptr_deref_187_load_0_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_request/word_access/word_access_0/ra
                Xexit_705_symbol <= ra_707_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_request/word_access/word_access_0/$exit
                word_access_0_703_symbol <= Xexit_705_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_request/word_access/word_access_0
              Xexit_702_symbol <= word_access_0_703_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_request/word_access/$exit
              word_access_700_symbol <= Xexit_702_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_request/word_access
            Xexit_699_symbol <= word_access_700_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_request/$exit
            ptr_deref_187_request_697_symbol <= Xexit_699_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_request
          ptr_deref_187_complete_708: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_complete 
            signal ptr_deref_187_complete_708_start: Boolean;
            signal Xentry_709_symbol: Boolean;
            signal Xexit_710_symbol: Boolean;
            signal word_access_711_symbol : Boolean;
            signal merge_req_719_symbol : Boolean;
            signal merge_ack_720_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_187_complete_708_start <= ptr_deref_187_active_x_x676_symbol; -- control passed to block
            Xentry_709_symbol  <= ptr_deref_187_complete_708_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_complete/$entry
            word_access_711: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_complete/word_access 
              signal word_access_711_start: Boolean;
              signal Xentry_712_symbol: Boolean;
              signal Xexit_713_symbol: Boolean;
              signal word_access_0_714_symbol : Boolean;
              -- 
            begin -- 
              word_access_711_start <= Xentry_709_symbol; -- control passed to block
              Xentry_712_symbol  <= word_access_711_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_complete/word_access/$entry
              word_access_0_714: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_complete/word_access/word_access_0 
                signal word_access_0_714_start: Boolean;
                signal Xentry_715_symbol: Boolean;
                signal Xexit_716_symbol: Boolean;
                signal cr_717_symbol : Boolean;
                signal ca_718_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_714_start <= Xentry_712_symbol; -- control passed to block
                Xentry_715_symbol  <= word_access_0_714_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_complete/word_access/word_access_0/$entry
                cr_717_symbol <= Xentry_715_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_complete/word_access/word_access_0/cr
                ptr_deref_187_load_0_req_1 <= cr_717_symbol; -- link to DP
                ca_718_symbol <= ptr_deref_187_load_0_ack_1; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_complete/word_access/word_access_0/ca
                Xexit_716_symbol <= ca_718_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_complete/word_access/word_access_0/$exit
                word_access_0_714_symbol <= Xexit_716_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_complete/word_access/word_access_0
              Xexit_713_symbol <= word_access_0_714_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_complete/word_access/$exit
              word_access_711_symbol <= Xexit_713_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_complete/word_access
            merge_req_719_symbol <= word_access_711_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_complete/merge_req
            ptr_deref_187_gather_scatter_req_0 <= merge_req_719_symbol; -- link to DP
            merge_ack_720_symbol <= ptr_deref_187_gather_scatter_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_complete/merge_ack
            Xexit_710_symbol <= merge_ack_720_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_complete/$exit
            ptr_deref_187_complete_708_symbol <= Xexit_710_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/ptr_deref_187_complete
          simple_obj_ref_185_trigger_x_x721_symbol <= assign_stmt_188_active_x_x673_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/simple_obj_ref_185_trigger_
          simple_obj_ref_185_complete_722: Block -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/simple_obj_ref_185_complete 
            signal simple_obj_ref_185_complete_722_start: Boolean;
            signal Xentry_723_symbol: Boolean;
            signal Xexit_724_symbol: Boolean;
            signal pipe_wreq_725_symbol : Boolean;
            signal pipe_wack_726_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_185_complete_722_start <= simple_obj_ref_185_trigger_x_x721_symbol; -- control passed to block
            Xentry_723_symbol  <= simple_obj_ref_185_complete_722_start; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/simple_obj_ref_185_complete/$entry
            pipe_wreq_725_symbol <= Xentry_723_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/simple_obj_ref_185_complete/pipe_wreq
            simple_obj_ref_185_inst_req_0 <= pipe_wreq_725_symbol; -- link to DP
            pipe_wack_726_symbol <= simple_obj_ref_185_inst_ack_0; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/simple_obj_ref_185_complete/pipe_wack
            Xexit_724_symbol <= pipe_wack_726_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/simple_obj_ref_185_complete/$exit
            simple_obj_ref_185_complete_722_symbol <= Xexit_724_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/simple_obj_ref_185_complete
          Xexit_672_symbol <= assign_stmt_188_completed_x_x674_symbol; -- transition branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188/$exit
          assign_stmt_188_670_symbol <= Xexit_672_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_157/parallel_block_stmt_180/assign_stmt_188
        Xexit_612_block : Block -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_180/$exit 
          signal Xexit_612_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_612_predecessors(0) <= assign_stmt_184_613_symbol;
          Xexit_612_predecessors(1) <= assign_stmt_188_670_symbol;
          Xexit_612_join: join -- 
            port map( -- 
              preds => Xexit_612_predecessors,
              symbol_out => Xexit_612_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_157/parallel_block_stmt_180/$exit
        parallel_block_stmt_180_610_symbol <= Xexit_612_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_157/parallel_block_stmt_180
      if_stmt_190_dead_link_727: Block -- branch_block_stmt_157/if_stmt_190_dead_link 
        signal if_stmt_190_dead_link_727_start: Boolean;
        signal Xentry_728_symbol: Boolean;
        signal Xexit_729_symbol: Boolean;
        signal dead_transition_730_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_190_dead_link_727_start <= if_stmt_190_x_xentry_x_xx_x494_symbol; -- control passed to block
        Xentry_728_symbol  <= if_stmt_190_dead_link_727_start; -- transition branch_block_stmt_157/if_stmt_190_dead_link/$entry
        dead_transition_730_symbol <= false;
        Xexit_729_symbol <= dead_transition_730_symbol; -- transition branch_block_stmt_157/if_stmt_190_dead_link/$exit
        if_stmt_190_dead_link_727_symbol <= Xexit_729_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_157/if_stmt_190_dead_link
      if_stmt_190_eval_test_731: Block -- branch_block_stmt_157/if_stmt_190_eval_test 
        signal if_stmt_190_eval_test_731_start: Boolean;
        signal Xentry_732_symbol: Boolean;
        signal Xexit_733_symbol: Boolean;
        signal binary_193_734_symbol : Boolean;
        signal branch_req_744_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_190_eval_test_731_start <= if_stmt_190_x_xentry_x_xx_x494_symbol; -- control passed to block
        Xentry_732_symbol  <= if_stmt_190_eval_test_731_start; -- transition branch_block_stmt_157/if_stmt_190_eval_test/$entry
        binary_193_734: Block -- branch_block_stmt_157/if_stmt_190_eval_test/binary_193 
          signal binary_193_734_start: Boolean;
          signal Xentry_735_symbol: Boolean;
          signal Xexit_736_symbol: Boolean;
          signal binary_193_inputs_737_symbol : Boolean;
          signal rr_740_symbol : Boolean;
          signal ra_741_symbol : Boolean;
          signal cr_742_symbol : Boolean;
          signal ca_743_symbol : Boolean;
          -- 
        begin -- 
          binary_193_734_start <= Xentry_732_symbol; -- control passed to block
          Xentry_735_symbol  <= binary_193_734_start; -- transition branch_block_stmt_157/if_stmt_190_eval_test/binary_193/$entry
          binary_193_inputs_737: Block -- branch_block_stmt_157/if_stmt_190_eval_test/binary_193/binary_193_inputs 
            signal binary_193_inputs_737_start: Boolean;
            signal Xentry_738_symbol: Boolean;
            signal Xexit_739_symbol: Boolean;
            -- 
          begin -- 
            binary_193_inputs_737_start <= Xentry_735_symbol; -- control passed to block
            Xentry_738_symbol  <= binary_193_inputs_737_start; -- transition branch_block_stmt_157/if_stmt_190_eval_test/binary_193/binary_193_inputs/$entry
            Xexit_739_symbol <= Xentry_738_symbol; -- transition branch_block_stmt_157/if_stmt_190_eval_test/binary_193/binary_193_inputs/$exit
            binary_193_inputs_737_symbol <= Xexit_739_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_157/if_stmt_190_eval_test/binary_193/binary_193_inputs
          rr_740_symbol <= binary_193_inputs_737_symbol; -- transition branch_block_stmt_157/if_stmt_190_eval_test/binary_193/rr
          binary_193_inst_req_0 <= rr_740_symbol; -- link to DP
          ra_741_symbol <= binary_193_inst_ack_0; -- transition branch_block_stmt_157/if_stmt_190_eval_test/binary_193/ra
          cr_742_symbol <= ra_741_symbol; -- transition branch_block_stmt_157/if_stmt_190_eval_test/binary_193/cr
          binary_193_inst_req_1 <= cr_742_symbol; -- link to DP
          ca_743_symbol <= binary_193_inst_ack_1; -- transition branch_block_stmt_157/if_stmt_190_eval_test/binary_193/ca
          Xexit_736_symbol <= ca_743_symbol; -- transition branch_block_stmt_157/if_stmt_190_eval_test/binary_193/$exit
          binary_193_734_symbol <= Xexit_736_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_157/if_stmt_190_eval_test/binary_193
        branch_req_744_symbol <= binary_193_734_symbol; -- transition branch_block_stmt_157/if_stmt_190_eval_test/branch_req
        if_stmt_190_branch_req_0 <= branch_req_744_symbol; -- link to DP
        Xexit_733_symbol <= branch_req_744_symbol; -- transition branch_block_stmt_157/if_stmt_190_eval_test/$exit
        if_stmt_190_eval_test_731_symbol <= Xexit_733_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_157/if_stmt_190_eval_test
      binary_193_place_745_symbol  <=  if_stmt_190_eval_test_731_symbol; -- place branch_block_stmt_157/binary_193_place (optimized away) 
      if_stmt_190_if_link_746: Block -- branch_block_stmt_157/if_stmt_190_if_link 
        signal if_stmt_190_if_link_746_start: Boolean;
        signal Xentry_747_symbol: Boolean;
        signal Xexit_748_symbol: Boolean;
        signal if_choice_transition_749_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_190_if_link_746_start <= binary_193_place_745_symbol; -- control passed to block
        Xentry_747_symbol  <= if_stmt_190_if_link_746_start; -- transition branch_block_stmt_157/if_stmt_190_if_link/$entry
        if_choice_transition_749_symbol <= if_stmt_190_branch_ack_1; -- transition branch_block_stmt_157/if_stmt_190_if_link/if_choice_transition
        Xexit_748_symbol <= if_choice_transition_749_symbol; -- transition branch_block_stmt_157/if_stmt_190_if_link/$exit
        if_stmt_190_if_link_746_symbol <= Xexit_748_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_157/if_stmt_190_if_link
      if_stmt_190_else_link_750: Block -- branch_block_stmt_157/if_stmt_190_else_link 
        signal if_stmt_190_else_link_750_start: Boolean;
        signal Xentry_751_symbol: Boolean;
        signal Xexit_752_symbol: Boolean;
        signal else_choice_transition_753_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_190_else_link_750_start <= binary_193_place_745_symbol; -- control passed to block
        Xentry_751_symbol  <= if_stmt_190_else_link_750_start; -- transition branch_block_stmt_157/if_stmt_190_else_link/$entry
        else_choice_transition_753_symbol <= if_stmt_190_branch_ack_0; -- transition branch_block_stmt_157/if_stmt_190_else_link/else_choice_transition
        Xexit_752_symbol <= else_choice_transition_753_symbol; -- transition branch_block_stmt_157/if_stmt_190_else_link/$exit
        if_stmt_190_else_link_750_symbol <= Xexit_752_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_157/if_stmt_190_else_link
      loopback_754_symbol  <=  if_stmt_190_if_link_746_symbol; -- place branch_block_stmt_157/loopback (optimized away) 
      if_stmt_190_else_link_to_if_stmt_190_x_xexit_x_xx_x755_symbol  <=  if_stmt_190_else_link_750_symbol; -- place branch_block_stmt_157/if_stmt_190_else_link_to_if_stmt_190__exit__ (optimized away) 
      merge_stmt_158_dead_link_756: Block -- branch_block_stmt_157/merge_stmt_158_dead_link 
        signal merge_stmt_158_dead_link_756_start: Boolean;
        signal Xentry_757_symbol: Boolean;
        signal Xexit_758_symbol: Boolean;
        signal dead_transition_759_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_158_dead_link_756_start <= merge_stmt_158_x_xentry_x_xx_x488_symbol; -- control passed to block
        Xentry_757_symbol  <= merge_stmt_158_dead_link_756_start; -- transition branch_block_stmt_157/merge_stmt_158_dead_link/$entry
        dead_transition_759_symbol <= false;
        Xexit_758_symbol <= dead_transition_759_symbol; -- transition branch_block_stmt_157/merge_stmt_158_dead_link/$exit
        merge_stmt_158_dead_link_756_symbol <= Xexit_758_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_157/merge_stmt_158_dead_link
      merge_stmt_158_x_xentry_x_xx_xPhiReq_760: Block -- branch_block_stmt_157/merge_stmt_158__entry___PhiReq 
        signal merge_stmt_158_x_xentry_x_xx_xPhiReq_760_start: Boolean;
        signal Xentry_761_symbol: Boolean;
        signal Xexit_762_symbol: Boolean;
        signal phi_stmt_159_763_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_158_x_xentry_x_xx_xPhiReq_760_start <= merge_stmt_158_x_xentry_x_xx_x488_symbol; -- control passed to block
        Xentry_761_symbol  <= merge_stmt_158_x_xentry_x_xx_xPhiReq_760_start; -- transition branch_block_stmt_157/merge_stmt_158__entry___PhiReq/$entry
        phi_stmt_159_763: Block -- branch_block_stmt_157/merge_stmt_158__entry___PhiReq/phi_stmt_159 
          signal phi_stmt_159_763_start: Boolean;
          signal Xentry_764_symbol: Boolean;
          signal Xexit_765_symbol: Boolean;
          signal phi_stmt_159_req_766_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_159_763_start <= Xentry_761_symbol; -- control passed to block
          Xentry_764_symbol  <= phi_stmt_159_763_start; -- transition branch_block_stmt_157/merge_stmt_158__entry___PhiReq/phi_stmt_159/$entry
          phi_stmt_159_req_766_symbol <= Xentry_764_symbol; -- transition branch_block_stmt_157/merge_stmt_158__entry___PhiReq/phi_stmt_159/phi_stmt_159_req
          phi_stmt_159_req_0 <= phi_stmt_159_req_766_symbol; -- link to DP
          Xexit_765_symbol <= phi_stmt_159_req_766_symbol; -- transition branch_block_stmt_157/merge_stmt_158__entry___PhiReq/phi_stmt_159/$exit
          phi_stmt_159_763_symbol <= Xexit_765_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_157/merge_stmt_158__entry___PhiReq/phi_stmt_159
        Xexit_762_symbol <= phi_stmt_159_763_symbol; -- transition branch_block_stmt_157/merge_stmt_158__entry___PhiReq/$exit
        merge_stmt_158_x_xentry_x_xx_xPhiReq_760_symbol <= Xexit_762_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_157/merge_stmt_158__entry___PhiReq
      loopback_PhiReq_767: Block -- branch_block_stmt_157/loopback_PhiReq 
        signal loopback_PhiReq_767_start: Boolean;
        signal Xentry_768_symbol: Boolean;
        signal Xexit_769_symbol: Boolean;
        signal phi_stmt_159_770_symbol : Boolean;
        -- 
      begin -- 
        loopback_PhiReq_767_start <= loopback_754_symbol; -- control passed to block
        Xentry_768_symbol  <= loopback_PhiReq_767_start; -- transition branch_block_stmt_157/loopback_PhiReq/$entry
        phi_stmt_159_770: Block -- branch_block_stmt_157/loopback_PhiReq/phi_stmt_159 
          signal phi_stmt_159_770_start: Boolean;
          signal Xentry_771_symbol: Boolean;
          signal Xexit_772_symbol: Boolean;
          signal phi_stmt_159_req_773_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_159_770_start <= Xentry_768_symbol; -- control passed to block
          Xentry_771_symbol  <= phi_stmt_159_770_start; -- transition branch_block_stmt_157/loopback_PhiReq/phi_stmt_159/$entry
          phi_stmt_159_req_773_symbol <= Xentry_771_symbol; -- transition branch_block_stmt_157/loopback_PhiReq/phi_stmt_159/phi_stmt_159_req
          phi_stmt_159_req_1 <= phi_stmt_159_req_773_symbol; -- link to DP
          Xexit_772_symbol <= phi_stmt_159_req_773_symbol; -- transition branch_block_stmt_157/loopback_PhiReq/phi_stmt_159/$exit
          phi_stmt_159_770_symbol <= Xexit_772_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_157/loopback_PhiReq/phi_stmt_159
        Xexit_769_symbol <= phi_stmt_159_770_symbol; -- transition branch_block_stmt_157/loopback_PhiReq/$exit
        loopback_PhiReq_767_symbol <= Xexit_769_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_157/loopback_PhiReq
      merge_stmt_158_PhiReqMerge_774_symbol  <=  merge_stmt_158_x_xentry_x_xx_xPhiReq_760_symbol or loopback_PhiReq_767_symbol; -- place branch_block_stmt_157/merge_stmt_158_PhiReqMerge (optimized away) 
      merge_stmt_158_PhiAck_775: Block -- branch_block_stmt_157/merge_stmt_158_PhiAck 
        signal merge_stmt_158_PhiAck_775_start: Boolean;
        signal Xentry_776_symbol: Boolean;
        signal Xexit_777_symbol: Boolean;
        signal phi_stmt_159_ack_778_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_158_PhiAck_775_start <= merge_stmt_158_PhiReqMerge_774_symbol; -- control passed to block
        Xentry_776_symbol  <= merge_stmt_158_PhiAck_775_start; -- transition branch_block_stmt_157/merge_stmt_158_PhiAck/$entry
        phi_stmt_159_ack_778_symbol <= phi_stmt_159_ack_0; -- transition branch_block_stmt_157/merge_stmt_158_PhiAck/phi_stmt_159_ack
        Xexit_777_symbol <= phi_stmt_159_ack_778_symbol; -- transition branch_block_stmt_157/merge_stmt_158_PhiAck/$exit
        merge_stmt_158_PhiAck_775_symbol <= Xexit_777_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_157/merge_stmt_158_PhiAck
      Xexit_485_symbol <= branch_block_stmt_157_x_xexit_x_xx_x487_symbol; -- transition branch_block_stmt_157/$exit
      branch_block_stmt_157_483_symbol <= Xexit_485_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_157
    Xexit_482_symbol <= branch_block_stmt_157_483_symbol; -- transition $exit
    fin  <=  '1' when Xexit_482_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal array_obj_ref_168_final_offset : std_logic_vector(9 downto 0);
    signal array_obj_ref_168_offset_scale_factor_0 : std_logic_vector(9 downto 0);
    signal array_obj_ref_168_resized_base_address : std_logic_vector(9 downto 0);
    signal array_obj_ref_168_root_address : std_logic_vector(9 downto 0);
    signal array_obj_ref_172_final_offset : std_logic_vector(9 downto 0);
    signal array_obj_ref_172_offset_scale_factor_0 : std_logic_vector(9 downto 0);
    signal array_obj_ref_172_resized_base_address : std_logic_vector(9 downto 0);
    signal array_obj_ref_172_root_address : std_logic_vector(9 downto 0);
    signal binary_193_wire : std_logic_vector(0 downto 0);
    signal cptr_169 : std_logic_vector(31 downto 0);
    signal dptr_173 : std_logic_vector(31 downto 0);
    signal expr_176_wire_constant : std_logic_vector(31 downto 0);
    signal nsentlength_178 : std_logic_vector(31 downto 0);
    signal ptr_deref_183_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_183_resized_base_address : std_logic_vector(9 downto 0);
    signal ptr_deref_183_root_address : std_logic_vector(9 downto 0);
    signal ptr_deref_183_wire : std_logic_vector(7 downto 0);
    signal ptr_deref_183_word_address_0 : std_logic_vector(9 downto 0);
    signal ptr_deref_183_word_offset_0 : std_logic_vector(9 downto 0);
    signal ptr_deref_187_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_187_resized_base_address : std_logic_vector(9 downto 0);
    signal ptr_deref_187_root_address : std_logic_vector(9 downto 0);
    signal ptr_deref_187_wire : std_logic_vector(63 downto 0);
    signal ptr_deref_187_word_address_0 : std_logic_vector(9 downto 0);
    signal ptr_deref_187_word_offset_0 : std_logic_vector(9 downto 0);
    signal sentlength_159 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_167_resized : std_logic_vector(9 downto 0);
    signal simple_obj_ref_167_scaled : std_logic_vector(9 downto 0);
    signal simple_obj_ref_171_resized : std_logic_vector(9 downto 0);
    signal simple_obj_ref_171_scaled : std_logic_vector(9 downto 0);
    signal type_cast_162_wire_constant : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    array_obj_ref_168_offset_scale_factor_0 <= "0000000001";
    array_obj_ref_172_offset_scale_factor_0 <= "0000000001";
    expr_176_wire_constant <= "00000000000000000000000000000001";
    ptr_deref_183_word_offset_0 <= "0000000000";
    ptr_deref_187_word_offset_0 <= "0000000000";
    type_cast_162_wire_constant <= "00000000000000000000000000000000";
    phi_stmt_159: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_162_wire_constant & nsentlength_178;
      req <= phi_stmt_159_req_0 & phi_stmt_159_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_159_ack_0,
          idata => idata,
          odata => sentlength_159,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_159
    array_obj_ref_168_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 10, flow_through => true ) 
      port map( din => ctrlptr, dout => array_obj_ref_168_resized_base_address, req => array_obj_ref_168_base_resize_req_0, ack => array_obj_ref_168_base_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_168_final_reg: RegisterBase --
      generic map(in_data_width => 10,out_data_width => 32, flow_through => false ) 
      port map( din => array_obj_ref_168_root_address, dout => cptr_169, req => array_obj_ref_168_final_reg_req_0, ack => array_obj_ref_168_final_reg_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_168_index_0_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 10, flow_through => true ) 
      port map( din => sentlength_159, dout => simple_obj_ref_167_resized, req => array_obj_ref_168_index_0_resize_req_0, ack => array_obj_ref_168_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_168_offset_inst: RegisterBase --
      generic map(in_data_width => 10,out_data_width => 10, flow_through => true ) 
      port map( din => simple_obj_ref_167_scaled, dout => array_obj_ref_168_final_offset, req => array_obj_ref_168_offset_inst_req_0, ack => array_obj_ref_168_offset_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_172_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 10, flow_through => true ) 
      port map( din => dataptr, dout => array_obj_ref_172_resized_base_address, req => array_obj_ref_172_base_resize_req_0, ack => array_obj_ref_172_base_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_172_final_reg: RegisterBase --
      generic map(in_data_width => 10,out_data_width => 32, flow_through => false ) 
      port map( din => array_obj_ref_172_root_address, dout => dptr_173, req => array_obj_ref_172_final_reg_req_0, ack => array_obj_ref_172_final_reg_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_172_index_0_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 10, flow_through => true ) 
      port map( din => sentlength_159, dout => simple_obj_ref_171_resized, req => array_obj_ref_172_index_0_resize_req_0, ack => array_obj_ref_172_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_172_offset_inst: RegisterBase --
      generic map(in_data_width => 10,out_data_width => 10, flow_through => true ) 
      port map( din => simple_obj_ref_171_scaled, dout => array_obj_ref_172_final_offset, req => array_obj_ref_172_offset_inst_req_0, ack => array_obj_ref_172_offset_inst_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_183_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 10, flow_through => true ) 
      port map( din => cptr_169, dout => ptr_deref_183_resized_base_address, req => ptr_deref_183_base_resize_req_0, ack => ptr_deref_183_base_resize_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_187_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 10, flow_through => true ) 
      port map( din => dptr_173, dout => ptr_deref_187_resized_base_address, req => ptr_deref_187_base_resize_req_0, ack => ptr_deref_187_base_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_168_index_0_rename: Block -- 
      signal aggregated_sig: std_logic_vector(9 downto 0); --
    begin -- 
      array_obj_ref_168_index_0_rename_ack_0 <= array_obj_ref_168_index_0_rename_req_0;
      aggregated_sig <= simple_obj_ref_167_resized;
      simple_obj_ref_167_scaled <= aggregated_sig(9 downto 0);
      --
    end Block;
    array_obj_ref_172_index_0_rename: Block -- 
      signal aggregated_sig: std_logic_vector(9 downto 0); --
    begin -- 
      array_obj_ref_172_index_0_rename_ack_0 <= array_obj_ref_172_index_0_rename_req_0;
      aggregated_sig <= simple_obj_ref_171_resized;
      simple_obj_ref_171_scaled <= aggregated_sig(9 downto 0);
      --
    end Block;
    ptr_deref_183_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(9 downto 0); --
    begin -- 
      ptr_deref_183_addr_0_ack_0 <= ptr_deref_183_addr_0_req_0;
      aggregated_sig <= ptr_deref_183_root_address;
      ptr_deref_183_word_address_0 <= aggregated_sig(9 downto 0);
      --
    end Block;
    ptr_deref_183_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_183_gather_scatter_ack_0 <= ptr_deref_183_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_183_data_0;
      ptr_deref_183_wire <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_183_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(9 downto 0); --
    begin -- 
      ptr_deref_183_root_address_inst_ack_0 <= ptr_deref_183_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_183_resized_base_address;
      ptr_deref_183_root_address <= aggregated_sig(9 downto 0);
      --
    end Block;
    ptr_deref_187_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(9 downto 0); --
    begin -- 
      ptr_deref_187_addr_0_ack_0 <= ptr_deref_187_addr_0_req_0;
      aggregated_sig <= ptr_deref_187_root_address;
      ptr_deref_187_word_address_0 <= aggregated_sig(9 downto 0);
      --
    end Block;
    ptr_deref_187_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_187_gather_scatter_ack_0 <= ptr_deref_187_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_187_data_0;
      ptr_deref_187_wire <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_187_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(9 downto 0); --
    begin -- 
      ptr_deref_187_root_address_inst_ack_0 <= ptr_deref_187_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_187_resized_base_address;
      ptr_deref_187_root_address <= aggregated_sig(9 downto 0);
      --
    end Block;
    if_stmt_190_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= binary_193_wire;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_190_branch_req_0,
          ack0 => if_stmt_190_branch_ack_0,
          ack1 => if_stmt_190_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : array_obj_ref_168_root_address_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(19 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= array_obj_ref_168_final_offset & array_obj_ref_168_resized_base_address;
      array_obj_ref_168_root_address <= data_out(9 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 10, 
          num_inputs    => 2,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 10,
          constant_operand => "0",
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => array_obj_ref_168_root_address_inst_req_0,
          ackL => array_obj_ref_168_root_address_inst_ack_0,
          reqR => array_obj_ref_168_root_address_inst_req_1,
          ackR => array_obj_ref_168_root_address_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : array_obj_ref_172_root_address_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(19 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= array_obj_ref_172_final_offset & array_obj_ref_172_resized_base_address;
      array_obj_ref_172_root_address <= data_out(9 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 10, 
          num_inputs    => 2,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 10,
          constant_operand => "0",
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => array_obj_ref_172_root_address_inst_req_0,
          ackL => array_obj_ref_172_root_address_inst_ack_0,
          reqR => array_obj_ref_172_root_address_inst_req_1,
          ackR => array_obj_ref_172_root_address_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : binary_177_inst 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= sentlength_159;
      nsentlength_178 <= data_out(31 downto 0);
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
    end Block; -- split operator group 2
    -- shared split operator group (3) : binary_193_inst 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= nsentlength_178 & pktlength;
      binary_193_wire <= data_out(0 downto 0);
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
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_193_inst_req_0,
          ackL => binary_193_inst_ack_0,
          reqR => binary_193_inst_req_1,
          ackR => binary_193_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared load operator group (0) : ptr_deref_183_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_183_load_0_req_0;
      ptr_deref_183_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_183_load_0_req_1;
      ptr_deref_183_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_183_word_address_0;
      ptr_deref_183_data_0 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 10,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_1_lr_req(0),
          mack => memory_space_1_lr_ack(0),
          maddr => memory_space_1_lr_addr(9 downto 0),
          mtag => memory_space_1_lr_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_1_lc_req(0),
          mack => memory_space_1_lc_ack(0),
          mdata => memory_space_1_lc_data(7 downto 0),
          mtag => memory_space_1_lc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- shared load operator group (1) : ptr_deref_187_load_0 
    LoadGroup1: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_187_load_0_req_0;
      ptr_deref_187_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_187_load_0_req_1;
      ptr_deref_187_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_187_word_address_0;
      ptr_deref_187_data_0 <= data_out(63 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 10,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_2_lr_req(0),
          mack => memory_space_2_lr_ack(0),
          maddr => memory_space_2_lr_addr(9 downto 0),
          mtag => memory_space_2_lr_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 64,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_2_lc_req(0),
          mack => memory_space_2_lc_ack(0),
          mdata => memory_space_2_lc_data(63 downto 0),
          mtag => memory_space_2_lc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 1
    -- shared outport operator group (0) : simple_obj_ref_181_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_181_inst_req_0;
      simple_obj_ref_181_inst_ack_0 <= ack(0);
      data_in <= ptr_deref_183_wire;
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
    -- shared outport operator group (1) : simple_obj_ref_185_inst 
    OutportGroup1: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_185_inst_req_0;
      simple_obj_ref_185_inst_ack_0 <= ack(0);
      data_in <= ptr_deref_187_wire;
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
entity send_packet is -- 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    send_msg_pipe_read_req : out  std_logic_vector(0 downto 0);
    send_msg_pipe_read_ack : in   std_logic_vector(0 downto 0);
    send_msg_pipe_read_data : in   std_logic_vector(31 downto 0);
    free_index_pipe_pipe_write_req : out  std_logic_vector(0 downto 0);
    free_index_pipe_pipe_write_ack : in   std_logic_vector(0 downto 0);
    free_index_pipe_pipe_write_data : out  std_logic_vector(31 downto 0);
    remove_packet_call_reqs : out  std_logic_vector(0 downto 0);
    remove_packet_call_acks : in   std_logic_vector(0 downto 0);
    remove_packet_call_data : out  std_logic_vector(95 downto 0);
    remove_packet_call_tag  :  out  std_logic_vector(0 downto 0);
    remove_packet_return_reqs : out  std_logic_vector(0 downto 0);
    remove_packet_return_acks : in   std_logic_vector(0 downto 0);
    remove_packet_return_tag :  in   std_logic_vector(0 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity send_packet;
architecture Default of send_packet is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal binary_67_inst_ack_1 : boolean;
  signal simple_obj_ref_61_inst_req_0 : boolean;
  signal simple_obj_ref_61_inst_ack_0 : boolean;
  signal binary_67_inst_ack_0 : boolean;
  signal array_obj_ref_75_index_0_resize_req_0 : boolean;
  signal array_obj_ref_75_index_sum_1_ack_0 : boolean;
  signal array_obj_ref_75_index_sum_1_req_1 : boolean;
  signal binary_67_inst_req_0 : boolean;
  signal simple_obj_ref_46_inst_ack_0 : boolean;
  signal simple_obj_ref_46_inst_req_0 : boolean;
  signal binary_67_inst_req_1 : boolean;
  signal array_obj_ref_81_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_75_root_address_inst_ack_0 : boolean;
  signal simple_obj_ref_69_inst_ack_0 : boolean;
  signal array_obj_ref_81_index_sum_1_req_0 : boolean;
  signal array_obj_ref_75_offset_inst_ack_0 : boolean;
  signal array_obj_ref_81_index_0_scale_req_1 : boolean;
  signal array_obj_ref_81_index_0_scale_ack_1 : boolean;
  signal array_obj_ref_81_index_0_scale_ack_0 : boolean;
  signal array_obj_ref_81_index_sum_1_ack_0 : boolean;
  signal array_obj_ref_81_index_0_resize_req_0 : boolean;
  signal array_obj_ref_81_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_81_index_0_scale_req_0 : boolean;
  signal array_obj_ref_75_offset_inst_req_0 : boolean;
  signal array_obj_ref_75_index_0_scale_req_1 : boolean;
  signal array_obj_ref_75_index_0_scale_ack_1 : boolean;
  signal addr_of_76_final_reg_req_0 : boolean;
  signal array_obj_ref_75_index_sum_1_req_0 : boolean;
  signal array_obj_ref_75_index_0_resize_ack_0 : boolean;
  signal addr_of_76_final_reg_ack_0 : boolean;
  signal array_obj_ref_75_index_0_scale_ack_0 : boolean;
  signal array_obj_ref_75_root_address_inst_req_0 : boolean;
  signal array_obj_ref_75_index_0_scale_req_0 : boolean;
  signal simple_obj_ref_69_inst_req_0 : boolean;
  signal type_cast_58_inst_req_0 : boolean;
  signal type_cast_58_inst_ack_0 : boolean;
  signal array_obj_ref_81_root_address_inst_req_0 : boolean;
  signal array_obj_ref_81_index_sum_1_req_1 : boolean;
  signal array_obj_ref_81_index_sum_1_ack_1 : boolean;
  signal array_obj_ref_81_offset_inst_ack_0 : boolean;
  signal call_stmt_87_call_req_1 : boolean;
  signal call_stmt_87_call_ack_1 : boolean;
  signal phi_stmt_52_req_1 : boolean;
  signal call_stmt_87_call_ack_0 : boolean;
  signal array_obj_ref_81_offset_inst_req_0 : boolean;
  signal phi_stmt_52_ack_0 : boolean;
  signal call_stmt_87_call_req_0 : boolean;
  signal phi_stmt_52_req_0 : boolean;
  signal addr_of_82_final_reg_req_0 : boolean;
  signal addr_of_82_final_reg_ack_0 : boolean;
  signal array_obj_ref_75_index_sum_1_ack_1 : boolean;
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
  send_packet_CP_779: Block -- control-path 
    signal send_packet_CP_779_start: Boolean;
    signal Xentry_780_symbol: Boolean;
    signal Xexit_781_symbol: Boolean;
    signal branch_block_stmt_45_782_symbol : Boolean;
    -- 
  begin -- 
    send_packet_CP_779_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_780_symbol  <= send_packet_CP_779_start; -- transition $entry
    branch_block_stmt_45_782: Block -- branch_block_stmt_45 
      signal branch_block_stmt_45_782_start: Boolean;
      signal Xentry_783_symbol: Boolean;
      signal Xexit_784_symbol: Boolean;
      signal branch_block_stmt_45_x_xentry_x_xx_x785_symbol : Boolean;
      signal branch_block_stmt_45_x_xexit_x_xx_x786_symbol : Boolean;
      signal assign_stmt_49_x_xentry_x_xx_x787_symbol : Boolean;
      signal assign_stmt_49_x_xexit_x_xx_x788_symbol : Boolean;
      signal bb_0_bb_1_789_symbol : Boolean;
      signal merge_stmt_51_x_xexit_x_xx_x790_symbol : Boolean;
      signal assign_stmt_62_x_xentry_x_xx_x791_symbol : Boolean;
      signal assign_stmt_62_x_xexit_x_xx_x792_symbol : Boolean;
      signal assign_stmt_68_x_xentry_x_xx_x793_symbol : Boolean;
      signal assign_stmt_68_x_xexit_x_xx_x794_symbol : Boolean;
      signal assign_stmt_71_x_xentry_x_xx_x795_symbol : Boolean;
      signal assign_stmt_71_x_xexit_x_xx_x796_symbol : Boolean;
      signal assign_stmt_77_to_assign_stmt_83_x_xentry_x_xx_x797_symbol : Boolean;
      signal assign_stmt_77_to_assign_stmt_83_x_xexit_x_xx_x798_symbol : Boolean;
      signal call_stmt_87_x_xentry_x_xx_x799_symbol : Boolean;
      signal call_stmt_87_x_xexit_x_xx_x800_symbol : Boolean;
      signal bb_1_bb_1_801_symbol : Boolean;
      signal assign_stmt_49_802_symbol : Boolean;
      signal assign_stmt_62_813_symbol : Boolean;
      signal assign_stmt_68_824_symbol : Boolean;
      signal assign_stmt_71_839_symbol : Boolean;
      signal assign_stmt_77_to_assign_stmt_83_851_symbol : Boolean;
      signal call_stmt_87_936_symbol : Boolean;
      signal bb_0_bb_1_PhiReq_956_symbol : Boolean;
      signal bb_1_bb_1_PhiReq_968_symbol : Boolean;
      signal merge_stmt_51_PhiReqMerge_980_symbol : Boolean;
      signal merge_stmt_51_PhiAck_981_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_45_782_start <= Xentry_780_symbol; -- control passed to block
      Xentry_783_symbol  <= branch_block_stmt_45_782_start; -- transition branch_block_stmt_45/$entry
      branch_block_stmt_45_x_xentry_x_xx_x785_symbol  <=  Xentry_783_symbol; -- place branch_block_stmt_45/branch_block_stmt_45__entry__ (optimized away) 
      branch_block_stmt_45_x_xexit_x_xx_x786_symbol  <=   false ; -- place branch_block_stmt_45/branch_block_stmt_45__exit__ (optimized away) 
      assign_stmt_49_x_xentry_x_xx_x787_symbol  <=  branch_block_stmt_45_x_xentry_x_xx_x785_symbol; -- place branch_block_stmt_45/assign_stmt_49__entry__ (optimized away) 
      assign_stmt_49_x_xexit_x_xx_x788_symbol  <=  assign_stmt_49_802_symbol; -- place branch_block_stmt_45/assign_stmt_49__exit__ (optimized away) 
      bb_0_bb_1_789_symbol  <=  assign_stmt_49_x_xexit_x_xx_x788_symbol; -- place branch_block_stmt_45/bb_0_bb_1 (optimized away) 
      merge_stmt_51_x_xexit_x_xx_x790_symbol  <=  merge_stmt_51_PhiAck_981_symbol; -- place branch_block_stmt_45/merge_stmt_51__exit__ (optimized away) 
      assign_stmt_62_x_xentry_x_xx_x791_symbol  <=  merge_stmt_51_x_xexit_x_xx_x790_symbol; -- place branch_block_stmt_45/assign_stmt_62__entry__ (optimized away) 
      assign_stmt_62_x_xexit_x_xx_x792_symbol  <=  assign_stmt_62_813_symbol; -- place branch_block_stmt_45/assign_stmt_62__exit__ (optimized away) 
      assign_stmt_68_x_xentry_x_xx_x793_symbol  <=  assign_stmt_62_x_xexit_x_xx_x792_symbol; -- place branch_block_stmt_45/assign_stmt_68__entry__ (optimized away) 
      assign_stmt_68_x_xexit_x_xx_x794_symbol  <=  assign_stmt_68_824_symbol; -- place branch_block_stmt_45/assign_stmt_68__exit__ (optimized away) 
      assign_stmt_71_x_xentry_x_xx_x795_symbol  <=  assign_stmt_68_x_xexit_x_xx_x794_symbol; -- place branch_block_stmt_45/assign_stmt_71__entry__ (optimized away) 
      assign_stmt_71_x_xexit_x_xx_x796_symbol  <=  assign_stmt_71_839_symbol; -- place branch_block_stmt_45/assign_stmt_71__exit__ (optimized away) 
      assign_stmt_77_to_assign_stmt_83_x_xentry_x_xx_x797_symbol  <=  assign_stmt_71_x_xexit_x_xx_x796_symbol; -- place branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83__entry__ (optimized away) 
      assign_stmt_77_to_assign_stmt_83_x_xexit_x_xx_x798_symbol  <=  assign_stmt_77_to_assign_stmt_83_851_symbol; -- place branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83__exit__ (optimized away) 
      call_stmt_87_x_xentry_x_xx_x799_symbol  <=  assign_stmt_77_to_assign_stmt_83_x_xexit_x_xx_x798_symbol; -- place branch_block_stmt_45/call_stmt_87__entry__ (optimized away) 
      call_stmt_87_x_xexit_x_xx_x800_symbol  <=  call_stmt_87_936_symbol; -- place branch_block_stmt_45/call_stmt_87__exit__ (optimized away) 
      bb_1_bb_1_801_symbol  <=  call_stmt_87_x_xexit_x_xx_x800_symbol; -- place branch_block_stmt_45/bb_1_bb_1 (optimized away) 
      assign_stmt_49_802: Block -- branch_block_stmt_45/assign_stmt_49 
        signal assign_stmt_49_802_start: Boolean;
        signal Xentry_803_symbol: Boolean;
        signal Xexit_804_symbol: Boolean;
        signal assign_stmt_49_active_x_x805_symbol : Boolean;
        signal assign_stmt_49_completed_x_x806_symbol : Boolean;
        signal simple_obj_ref_46_trigger_x_x807_symbol : Boolean;
        signal simple_obj_ref_46_complete_808_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_49_802_start <= assign_stmt_49_x_xentry_x_xx_x787_symbol; -- control passed to block
        Xentry_803_symbol  <= assign_stmt_49_802_start; -- transition branch_block_stmt_45/assign_stmt_49/$entry
        assign_stmt_49_active_x_x805_symbol <= Xentry_803_symbol; -- transition branch_block_stmt_45/assign_stmt_49/assign_stmt_49_active_
        assign_stmt_49_completed_x_x806_symbol <= simple_obj_ref_46_complete_808_symbol; -- transition branch_block_stmt_45/assign_stmt_49/assign_stmt_49_completed_
        simple_obj_ref_46_trigger_x_x807_symbol <= assign_stmt_49_active_x_x805_symbol; -- transition branch_block_stmt_45/assign_stmt_49/simple_obj_ref_46_trigger_
        simple_obj_ref_46_complete_808: Block -- branch_block_stmt_45/assign_stmt_49/simple_obj_ref_46_complete 
          signal simple_obj_ref_46_complete_808_start: Boolean;
          signal Xentry_809_symbol: Boolean;
          signal Xexit_810_symbol: Boolean;
          signal pipe_wreq_811_symbol : Boolean;
          signal pipe_wack_812_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_46_complete_808_start <= simple_obj_ref_46_trigger_x_x807_symbol; -- control passed to block
          Xentry_809_symbol  <= simple_obj_ref_46_complete_808_start; -- transition branch_block_stmt_45/assign_stmt_49/simple_obj_ref_46_complete/$entry
          pipe_wreq_811_symbol <= Xentry_809_symbol; -- transition branch_block_stmt_45/assign_stmt_49/simple_obj_ref_46_complete/pipe_wreq
          simple_obj_ref_46_inst_req_0 <= pipe_wreq_811_symbol; -- link to DP
          pipe_wack_812_symbol <= simple_obj_ref_46_inst_ack_0; -- transition branch_block_stmt_45/assign_stmt_49/simple_obj_ref_46_complete/pipe_wack
          Xexit_810_symbol <= pipe_wack_812_symbol; -- transition branch_block_stmt_45/assign_stmt_49/simple_obj_ref_46_complete/$exit
          simple_obj_ref_46_complete_808_symbol <= Xexit_810_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/assign_stmt_49/simple_obj_ref_46_complete
        Xexit_804_symbol <= assign_stmt_49_completed_x_x806_symbol; -- transition branch_block_stmt_45/assign_stmt_49/$exit
        assign_stmt_49_802_symbol <= Xexit_804_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_45/assign_stmt_49
      assign_stmt_62_813: Block -- branch_block_stmt_45/assign_stmt_62 
        signal assign_stmt_62_813_start: Boolean;
        signal Xentry_814_symbol: Boolean;
        signal Xexit_815_symbol: Boolean;
        signal assign_stmt_62_active_x_x816_symbol : Boolean;
        signal assign_stmt_62_completed_x_x817_symbol : Boolean;
        signal simple_obj_ref_61_trigger_x_x818_symbol : Boolean;
        signal simple_obj_ref_61_complete_819_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_62_813_start <= assign_stmt_62_x_xentry_x_xx_x791_symbol; -- control passed to block
        Xentry_814_symbol  <= assign_stmt_62_813_start; -- transition branch_block_stmt_45/assign_stmt_62/$entry
        assign_stmt_62_active_x_x816_symbol <= simple_obj_ref_61_complete_819_symbol; -- transition branch_block_stmt_45/assign_stmt_62/assign_stmt_62_active_
        assign_stmt_62_completed_x_x817_symbol <= assign_stmt_62_active_x_x816_symbol; -- transition branch_block_stmt_45/assign_stmt_62/assign_stmt_62_completed_
        simple_obj_ref_61_trigger_x_x818_symbol <= Xentry_814_symbol; -- transition branch_block_stmt_45/assign_stmt_62/simple_obj_ref_61_trigger_
        simple_obj_ref_61_complete_819: Block -- branch_block_stmt_45/assign_stmt_62/simple_obj_ref_61_complete 
          signal simple_obj_ref_61_complete_819_start: Boolean;
          signal Xentry_820_symbol: Boolean;
          signal Xexit_821_symbol: Boolean;
          signal req_822_symbol : Boolean;
          signal ack_823_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_61_complete_819_start <= simple_obj_ref_61_trigger_x_x818_symbol; -- control passed to block
          Xentry_820_symbol  <= simple_obj_ref_61_complete_819_start; -- transition branch_block_stmt_45/assign_stmt_62/simple_obj_ref_61_complete/$entry
          req_822_symbol <= Xentry_820_symbol; -- transition branch_block_stmt_45/assign_stmt_62/simple_obj_ref_61_complete/req
          simple_obj_ref_61_inst_req_0 <= req_822_symbol; -- link to DP
          ack_823_symbol <= simple_obj_ref_61_inst_ack_0; -- transition branch_block_stmt_45/assign_stmt_62/simple_obj_ref_61_complete/ack
          Xexit_821_symbol <= ack_823_symbol; -- transition branch_block_stmt_45/assign_stmt_62/simple_obj_ref_61_complete/$exit
          simple_obj_ref_61_complete_819_symbol <= Xexit_821_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/assign_stmt_62/simple_obj_ref_61_complete
        Xexit_815_symbol <= assign_stmt_62_completed_x_x817_symbol; -- transition branch_block_stmt_45/assign_stmt_62/$exit
        assign_stmt_62_813_symbol <= Xexit_815_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_45/assign_stmt_62
      assign_stmt_68_824: Block -- branch_block_stmt_45/assign_stmt_68 
        signal assign_stmt_68_824_start: Boolean;
        signal Xentry_825_symbol: Boolean;
        signal Xexit_826_symbol: Boolean;
        signal assign_stmt_68_active_x_x827_symbol : Boolean;
        signal assign_stmt_68_completed_x_x828_symbol : Boolean;
        signal binary_67_active_x_x829_symbol : Boolean;
        signal binary_67_trigger_x_x830_symbol : Boolean;
        signal simple_obj_ref_66_complete_831_symbol : Boolean;
        signal binary_67_complete_832_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_68_824_start <= assign_stmt_68_x_xentry_x_xx_x793_symbol; -- control passed to block
        Xentry_825_symbol  <= assign_stmt_68_824_start; -- transition branch_block_stmt_45/assign_stmt_68/$entry
        assign_stmt_68_active_x_x827_symbol <= binary_67_complete_832_symbol; -- transition branch_block_stmt_45/assign_stmt_68/assign_stmt_68_active_
        assign_stmt_68_completed_x_x828_symbol <= assign_stmt_68_active_x_x827_symbol; -- transition branch_block_stmt_45/assign_stmt_68/assign_stmt_68_completed_
        binary_67_active_x_x829_block : Block -- non-trivial join transition branch_block_stmt_45/assign_stmt_68/binary_67_active_ 
          signal binary_67_active_x_x829_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_67_active_x_x829_predecessors(0) <= binary_67_trigger_x_x830_symbol;
          binary_67_active_x_x829_predecessors(1) <= simple_obj_ref_66_complete_831_symbol;
          binary_67_active_x_x829_join: join -- 
            port map( -- 
              preds => binary_67_active_x_x829_predecessors,
              symbol_out => binary_67_active_x_x829_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_45/assign_stmt_68/binary_67_active_
        binary_67_trigger_x_x830_symbol <= Xentry_825_symbol; -- transition branch_block_stmt_45/assign_stmt_68/binary_67_trigger_
        simple_obj_ref_66_complete_831_symbol <= Xentry_825_symbol; -- transition branch_block_stmt_45/assign_stmt_68/simple_obj_ref_66_complete
        binary_67_complete_832: Block -- branch_block_stmt_45/assign_stmt_68/binary_67_complete 
          signal binary_67_complete_832_start: Boolean;
          signal Xentry_833_symbol: Boolean;
          signal Xexit_834_symbol: Boolean;
          signal rr_835_symbol : Boolean;
          signal ra_836_symbol : Boolean;
          signal cr_837_symbol : Boolean;
          signal ca_838_symbol : Boolean;
          -- 
        begin -- 
          binary_67_complete_832_start <= binary_67_active_x_x829_symbol; -- control passed to block
          Xentry_833_symbol  <= binary_67_complete_832_start; -- transition branch_block_stmt_45/assign_stmt_68/binary_67_complete/$entry
          rr_835_symbol <= Xentry_833_symbol; -- transition branch_block_stmt_45/assign_stmt_68/binary_67_complete/rr
          binary_67_inst_req_0 <= rr_835_symbol; -- link to DP
          ra_836_symbol <= binary_67_inst_ack_0; -- transition branch_block_stmt_45/assign_stmt_68/binary_67_complete/ra
          cr_837_symbol <= ra_836_symbol; -- transition branch_block_stmt_45/assign_stmt_68/binary_67_complete/cr
          binary_67_inst_req_1 <= cr_837_symbol; -- link to DP
          ca_838_symbol <= binary_67_inst_ack_1; -- transition branch_block_stmt_45/assign_stmt_68/binary_67_complete/ca
          Xexit_834_symbol <= ca_838_symbol; -- transition branch_block_stmt_45/assign_stmt_68/binary_67_complete/$exit
          binary_67_complete_832_symbol <= Xexit_834_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/assign_stmt_68/binary_67_complete
        Xexit_826_symbol <= assign_stmt_68_completed_x_x828_symbol; -- transition branch_block_stmt_45/assign_stmt_68/$exit
        assign_stmt_68_824_symbol <= Xexit_826_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_45/assign_stmt_68
      assign_stmt_71_839: Block -- branch_block_stmt_45/assign_stmt_71 
        signal assign_stmt_71_839_start: Boolean;
        signal Xentry_840_symbol: Boolean;
        signal Xexit_841_symbol: Boolean;
        signal assign_stmt_71_active_x_x842_symbol : Boolean;
        signal assign_stmt_71_completed_x_x843_symbol : Boolean;
        signal simple_obj_ref_70_complete_844_symbol : Boolean;
        signal simple_obj_ref_69_trigger_x_x845_symbol : Boolean;
        signal simple_obj_ref_69_complete_846_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_71_839_start <= assign_stmt_71_x_xentry_x_xx_x795_symbol; -- control passed to block
        Xentry_840_symbol  <= assign_stmt_71_839_start; -- transition branch_block_stmt_45/assign_stmt_71/$entry
        assign_stmt_71_active_x_x842_symbol <= simple_obj_ref_70_complete_844_symbol; -- transition branch_block_stmt_45/assign_stmt_71/assign_stmt_71_active_
        assign_stmt_71_completed_x_x843_symbol <= simple_obj_ref_69_complete_846_symbol; -- transition branch_block_stmt_45/assign_stmt_71/assign_stmt_71_completed_
        simple_obj_ref_70_complete_844_symbol <= Xentry_840_symbol; -- transition branch_block_stmt_45/assign_stmt_71/simple_obj_ref_70_complete
        simple_obj_ref_69_trigger_x_x845_symbol <= assign_stmt_71_active_x_x842_symbol; -- transition branch_block_stmt_45/assign_stmt_71/simple_obj_ref_69_trigger_
        simple_obj_ref_69_complete_846: Block -- branch_block_stmt_45/assign_stmt_71/simple_obj_ref_69_complete 
          signal simple_obj_ref_69_complete_846_start: Boolean;
          signal Xentry_847_symbol: Boolean;
          signal Xexit_848_symbol: Boolean;
          signal pipe_wreq_849_symbol : Boolean;
          signal pipe_wack_850_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_69_complete_846_start <= simple_obj_ref_69_trigger_x_x845_symbol; -- control passed to block
          Xentry_847_symbol  <= simple_obj_ref_69_complete_846_start; -- transition branch_block_stmt_45/assign_stmt_71/simple_obj_ref_69_complete/$entry
          pipe_wreq_849_symbol <= Xentry_847_symbol; -- transition branch_block_stmt_45/assign_stmt_71/simple_obj_ref_69_complete/pipe_wreq
          simple_obj_ref_69_inst_req_0 <= pipe_wreq_849_symbol; -- link to DP
          pipe_wack_850_symbol <= simple_obj_ref_69_inst_ack_0; -- transition branch_block_stmt_45/assign_stmt_71/simple_obj_ref_69_complete/pipe_wack
          Xexit_848_symbol <= pipe_wack_850_symbol; -- transition branch_block_stmt_45/assign_stmt_71/simple_obj_ref_69_complete/$exit
          simple_obj_ref_69_complete_846_symbol <= Xexit_848_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/assign_stmt_71/simple_obj_ref_69_complete
        Xexit_841_symbol <= assign_stmt_71_completed_x_x843_symbol; -- transition branch_block_stmt_45/assign_stmt_71/$exit
        assign_stmt_71_839_symbol <= Xexit_841_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_45/assign_stmt_71
      assign_stmt_77_to_assign_stmt_83_851: Block -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83 
        signal assign_stmt_77_to_assign_stmt_83_851_start: Boolean;
        signal Xentry_852_symbol: Boolean;
        signal Xexit_853_symbol: Boolean;
        signal assign_stmt_77_active_x_x854_symbol : Boolean;
        signal assign_stmt_77_completed_x_x855_symbol : Boolean;
        signal addr_of_76_active_x_x856_symbol : Boolean;
        signal addr_of_76_trigger_x_x857_symbol : Boolean;
        signal array_obj_ref_75_root_address_calculated_858_symbol : Boolean;
        signal array_obj_ref_75_indices_scaled_859_symbol : Boolean;
        signal array_obj_ref_75_offset_calculated_860_symbol : Boolean;
        signal array_obj_ref_75_index_computed_0_861_symbol : Boolean;
        signal array_obj_ref_75_index_resized_0_862_symbol : Boolean;
        signal simple_obj_ref_73_complete_863_symbol : Boolean;
        signal array_obj_ref_75_index_resize_0_864_symbol : Boolean;
        signal array_obj_ref_75_index_scale_0_869_symbol : Boolean;
        signal array_obj_ref_75_add_indices_876_symbol : Boolean;
        signal array_obj_ref_75_base_plus_offset_885_symbol : Boolean;
        signal addr_of_76_complete_890_symbol : Boolean;
        signal assign_stmt_83_active_x_x895_symbol : Boolean;
        signal assign_stmt_83_completed_x_x896_symbol : Boolean;
        signal addr_of_82_active_x_x897_symbol : Boolean;
        signal addr_of_82_trigger_x_x898_symbol : Boolean;
        signal array_obj_ref_81_root_address_calculated_899_symbol : Boolean;
        signal array_obj_ref_81_indices_scaled_900_symbol : Boolean;
        signal array_obj_ref_81_offset_calculated_901_symbol : Boolean;
        signal array_obj_ref_81_index_computed_0_902_symbol : Boolean;
        signal array_obj_ref_81_index_resized_0_903_symbol : Boolean;
        signal simple_obj_ref_79_complete_904_symbol : Boolean;
        signal array_obj_ref_81_index_resize_0_905_symbol : Boolean;
        signal array_obj_ref_81_index_scale_0_910_symbol : Boolean;
        signal array_obj_ref_81_add_indices_917_symbol : Boolean;
        signal array_obj_ref_81_base_plus_offset_926_symbol : Boolean;
        signal addr_of_82_complete_931_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_77_to_assign_stmt_83_851_start <= assign_stmt_77_to_assign_stmt_83_x_xentry_x_xx_x797_symbol; -- control passed to block
        Xentry_852_symbol  <= assign_stmt_77_to_assign_stmt_83_851_start; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/$entry
        assign_stmt_77_active_x_x854_symbol <= addr_of_76_complete_890_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/assign_stmt_77_active_
        assign_stmt_77_completed_x_x855_symbol <= assign_stmt_77_active_x_x854_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/assign_stmt_77_completed_
        addr_of_76_active_x_x856_block : Block -- non-trivial join transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_76_active_ 
          signal addr_of_76_active_x_x856_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          addr_of_76_active_x_x856_predecessors(0) <= addr_of_76_trigger_x_x857_symbol;
          addr_of_76_active_x_x856_predecessors(1) <= array_obj_ref_75_root_address_calculated_858_symbol;
          addr_of_76_active_x_x856_join: join -- 
            port map( -- 
              preds => addr_of_76_active_x_x856_predecessors,
              symbol_out => addr_of_76_active_x_x856_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_76_active_
        addr_of_76_trigger_x_x857_symbol <= Xentry_852_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_76_trigger_
        array_obj_ref_75_root_address_calculated_858_symbol <= array_obj_ref_75_base_plus_offset_885_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_root_address_calculated
        array_obj_ref_75_indices_scaled_859_symbol <= array_obj_ref_75_index_scale_0_869_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_indices_scaled
        array_obj_ref_75_offset_calculated_860_symbol <= array_obj_ref_75_add_indices_876_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_offset_calculated
        array_obj_ref_75_index_computed_0_861_symbol <= simple_obj_ref_73_complete_863_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_index_computed_0
        array_obj_ref_75_index_resized_0_862_symbol <= array_obj_ref_75_index_resize_0_864_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_index_resized_0
        simple_obj_ref_73_complete_863_symbol <= Xentry_852_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/simple_obj_ref_73_complete
        array_obj_ref_75_index_resize_0_864: Block -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_index_resize_0 
          signal array_obj_ref_75_index_resize_0_864_start: Boolean;
          signal Xentry_865_symbol: Boolean;
          signal Xexit_866_symbol: Boolean;
          signal index_resize_req_867_symbol : Boolean;
          signal index_resize_ack_868_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_75_index_resize_0_864_start <= array_obj_ref_75_index_computed_0_861_symbol; -- control passed to block
          Xentry_865_symbol  <= array_obj_ref_75_index_resize_0_864_start; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_index_resize_0/$entry
          index_resize_req_867_symbol <= Xentry_865_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_index_resize_0/index_resize_req
          array_obj_ref_75_index_0_resize_req_0 <= index_resize_req_867_symbol; -- link to DP
          index_resize_ack_868_symbol <= array_obj_ref_75_index_0_resize_ack_0; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_index_resize_0/index_resize_ack
          Xexit_866_symbol <= index_resize_ack_868_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_index_resize_0/$exit
          array_obj_ref_75_index_resize_0_864_symbol <= Xexit_866_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_index_resize_0
        array_obj_ref_75_index_scale_0_869: Block -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_index_scale_0 
          signal array_obj_ref_75_index_scale_0_869_start: Boolean;
          signal Xentry_870_symbol: Boolean;
          signal Xexit_871_symbol: Boolean;
          signal scale_rr_872_symbol : Boolean;
          signal scale_ra_873_symbol : Boolean;
          signal scale_cr_874_symbol : Boolean;
          signal scale_ca_875_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_75_index_scale_0_869_start <= array_obj_ref_75_index_resized_0_862_symbol; -- control passed to block
          Xentry_870_symbol  <= array_obj_ref_75_index_scale_0_869_start; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_index_scale_0/$entry
          scale_rr_872_symbol <= Xentry_870_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_index_scale_0/scale_rr
          array_obj_ref_75_index_0_scale_req_0 <= scale_rr_872_symbol; -- link to DP
          scale_ra_873_symbol <= array_obj_ref_75_index_0_scale_ack_0; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_index_scale_0/scale_ra
          scale_cr_874_symbol <= scale_ra_873_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_index_scale_0/scale_cr
          array_obj_ref_75_index_0_scale_req_1 <= scale_cr_874_symbol; -- link to DP
          scale_ca_875_symbol <= array_obj_ref_75_index_0_scale_ack_1; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_index_scale_0/scale_ca
          Xexit_871_symbol <= scale_ca_875_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_index_scale_0/$exit
          array_obj_ref_75_index_scale_0_869_symbol <= Xexit_871_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_index_scale_0
        array_obj_ref_75_add_indices_876: Block -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_add_indices 
          signal array_obj_ref_75_add_indices_876_start: Boolean;
          signal Xentry_877_symbol: Boolean;
          signal Xexit_878_symbol: Boolean;
          signal partial_sum_1_rr_879_symbol : Boolean;
          signal partial_sum_1_ra_880_symbol : Boolean;
          signal partial_sum_1_cr_881_symbol : Boolean;
          signal partial_sum_1_ca_882_symbol : Boolean;
          signal final_index_req_883_symbol : Boolean;
          signal final_index_ack_884_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_75_add_indices_876_start <= array_obj_ref_75_indices_scaled_859_symbol; -- control passed to block
          Xentry_877_symbol  <= array_obj_ref_75_add_indices_876_start; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_add_indices/$entry
          partial_sum_1_rr_879_symbol <= Xentry_877_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_add_indices/partial_sum_1_rr
          array_obj_ref_75_index_sum_1_req_0 <= partial_sum_1_rr_879_symbol; -- link to DP
          partial_sum_1_ra_880_symbol <= array_obj_ref_75_index_sum_1_ack_0; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_add_indices/partial_sum_1_ra
          partial_sum_1_cr_881_symbol <= partial_sum_1_ra_880_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_add_indices/partial_sum_1_cr
          array_obj_ref_75_index_sum_1_req_1 <= partial_sum_1_cr_881_symbol; -- link to DP
          partial_sum_1_ca_882_symbol <= array_obj_ref_75_index_sum_1_ack_1; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_add_indices/partial_sum_1_ca
          final_index_req_883_symbol <= partial_sum_1_ca_882_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_add_indices/final_index_req
          array_obj_ref_75_offset_inst_req_0 <= final_index_req_883_symbol; -- link to DP
          final_index_ack_884_symbol <= array_obj_ref_75_offset_inst_ack_0; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_add_indices/final_index_ack
          Xexit_878_symbol <= final_index_ack_884_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_add_indices/$exit
          array_obj_ref_75_add_indices_876_symbol <= Xexit_878_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_add_indices
        array_obj_ref_75_base_plus_offset_885: Block -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_base_plus_offset 
          signal array_obj_ref_75_base_plus_offset_885_start: Boolean;
          signal Xentry_886_symbol: Boolean;
          signal Xexit_887_symbol: Boolean;
          signal sum_rename_req_888_symbol : Boolean;
          signal sum_rename_ack_889_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_75_base_plus_offset_885_start <= array_obj_ref_75_offset_calculated_860_symbol; -- control passed to block
          Xentry_886_symbol  <= array_obj_ref_75_base_plus_offset_885_start; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_base_plus_offset/$entry
          sum_rename_req_888_symbol <= Xentry_886_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_base_plus_offset/sum_rename_req
          array_obj_ref_75_root_address_inst_req_0 <= sum_rename_req_888_symbol; -- link to DP
          sum_rename_ack_889_symbol <= array_obj_ref_75_root_address_inst_ack_0; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_base_plus_offset/sum_rename_ack
          Xexit_887_symbol <= sum_rename_ack_889_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_base_plus_offset/$exit
          array_obj_ref_75_base_plus_offset_885_symbol <= Xexit_887_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_75_base_plus_offset
        addr_of_76_complete_890: Block -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_76_complete 
          signal addr_of_76_complete_890_start: Boolean;
          signal Xentry_891_symbol: Boolean;
          signal Xexit_892_symbol: Boolean;
          signal final_reg_req_893_symbol : Boolean;
          signal final_reg_ack_894_symbol : Boolean;
          -- 
        begin -- 
          addr_of_76_complete_890_start <= addr_of_76_active_x_x856_symbol; -- control passed to block
          Xentry_891_symbol  <= addr_of_76_complete_890_start; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_76_complete/$entry
          final_reg_req_893_symbol <= Xentry_891_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_76_complete/final_reg_req
          addr_of_76_final_reg_req_0 <= final_reg_req_893_symbol; -- link to DP
          final_reg_ack_894_symbol <= addr_of_76_final_reg_ack_0; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_76_complete/final_reg_ack
          Xexit_892_symbol <= final_reg_ack_894_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_76_complete/$exit
          addr_of_76_complete_890_symbol <= Xexit_892_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_76_complete
        assign_stmt_83_active_x_x895_symbol <= addr_of_82_complete_931_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/assign_stmt_83_active_
        assign_stmt_83_completed_x_x896_symbol <= assign_stmt_83_active_x_x895_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/assign_stmt_83_completed_
        addr_of_82_active_x_x897_block : Block -- non-trivial join transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_82_active_ 
          signal addr_of_82_active_x_x897_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          addr_of_82_active_x_x897_predecessors(0) <= addr_of_82_trigger_x_x898_symbol;
          addr_of_82_active_x_x897_predecessors(1) <= array_obj_ref_81_root_address_calculated_899_symbol;
          addr_of_82_active_x_x897_join: join -- 
            port map( -- 
              preds => addr_of_82_active_x_x897_predecessors,
              symbol_out => addr_of_82_active_x_x897_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_82_active_
        addr_of_82_trigger_x_x898_symbol <= Xentry_852_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_82_trigger_
        array_obj_ref_81_root_address_calculated_899_symbol <= array_obj_ref_81_base_plus_offset_926_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_root_address_calculated
        array_obj_ref_81_indices_scaled_900_symbol <= array_obj_ref_81_index_scale_0_910_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_indices_scaled
        array_obj_ref_81_offset_calculated_901_symbol <= array_obj_ref_81_add_indices_917_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_offset_calculated
        array_obj_ref_81_index_computed_0_902_symbol <= simple_obj_ref_79_complete_904_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_index_computed_0
        array_obj_ref_81_index_resized_0_903_symbol <= array_obj_ref_81_index_resize_0_905_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_index_resized_0
        simple_obj_ref_79_complete_904_symbol <= Xentry_852_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/simple_obj_ref_79_complete
        array_obj_ref_81_index_resize_0_905: Block -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_index_resize_0 
          signal array_obj_ref_81_index_resize_0_905_start: Boolean;
          signal Xentry_906_symbol: Boolean;
          signal Xexit_907_symbol: Boolean;
          signal index_resize_req_908_symbol : Boolean;
          signal index_resize_ack_909_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_81_index_resize_0_905_start <= array_obj_ref_81_index_computed_0_902_symbol; -- control passed to block
          Xentry_906_symbol  <= array_obj_ref_81_index_resize_0_905_start; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_index_resize_0/$entry
          index_resize_req_908_symbol <= Xentry_906_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_index_resize_0/index_resize_req
          array_obj_ref_81_index_0_resize_req_0 <= index_resize_req_908_symbol; -- link to DP
          index_resize_ack_909_symbol <= array_obj_ref_81_index_0_resize_ack_0; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_index_resize_0/index_resize_ack
          Xexit_907_symbol <= index_resize_ack_909_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_index_resize_0/$exit
          array_obj_ref_81_index_resize_0_905_symbol <= Xexit_907_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_index_resize_0
        array_obj_ref_81_index_scale_0_910: Block -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_index_scale_0 
          signal array_obj_ref_81_index_scale_0_910_start: Boolean;
          signal Xentry_911_symbol: Boolean;
          signal Xexit_912_symbol: Boolean;
          signal scale_rr_913_symbol : Boolean;
          signal scale_ra_914_symbol : Boolean;
          signal scale_cr_915_symbol : Boolean;
          signal scale_ca_916_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_81_index_scale_0_910_start <= array_obj_ref_81_index_resized_0_903_symbol; -- control passed to block
          Xentry_911_symbol  <= array_obj_ref_81_index_scale_0_910_start; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_index_scale_0/$entry
          scale_rr_913_symbol <= Xentry_911_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_index_scale_0/scale_rr
          array_obj_ref_81_index_0_scale_req_0 <= scale_rr_913_symbol; -- link to DP
          scale_ra_914_symbol <= array_obj_ref_81_index_0_scale_ack_0; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_index_scale_0/scale_ra
          scale_cr_915_symbol <= scale_ra_914_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_index_scale_0/scale_cr
          array_obj_ref_81_index_0_scale_req_1 <= scale_cr_915_symbol; -- link to DP
          scale_ca_916_symbol <= array_obj_ref_81_index_0_scale_ack_1; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_index_scale_0/scale_ca
          Xexit_912_symbol <= scale_ca_916_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_index_scale_0/$exit
          array_obj_ref_81_index_scale_0_910_symbol <= Xexit_912_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_index_scale_0
        array_obj_ref_81_add_indices_917: Block -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_add_indices 
          signal array_obj_ref_81_add_indices_917_start: Boolean;
          signal Xentry_918_symbol: Boolean;
          signal Xexit_919_symbol: Boolean;
          signal partial_sum_1_rr_920_symbol : Boolean;
          signal partial_sum_1_ra_921_symbol : Boolean;
          signal partial_sum_1_cr_922_symbol : Boolean;
          signal partial_sum_1_ca_923_symbol : Boolean;
          signal final_index_req_924_symbol : Boolean;
          signal final_index_ack_925_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_81_add_indices_917_start <= array_obj_ref_81_indices_scaled_900_symbol; -- control passed to block
          Xentry_918_symbol  <= array_obj_ref_81_add_indices_917_start; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_add_indices/$entry
          partial_sum_1_rr_920_symbol <= Xentry_918_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_add_indices/partial_sum_1_rr
          array_obj_ref_81_index_sum_1_req_0 <= partial_sum_1_rr_920_symbol; -- link to DP
          partial_sum_1_ra_921_symbol <= array_obj_ref_81_index_sum_1_ack_0; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_add_indices/partial_sum_1_ra
          partial_sum_1_cr_922_symbol <= partial_sum_1_ra_921_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_add_indices/partial_sum_1_cr
          array_obj_ref_81_index_sum_1_req_1 <= partial_sum_1_cr_922_symbol; -- link to DP
          partial_sum_1_ca_923_symbol <= array_obj_ref_81_index_sum_1_ack_1; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_add_indices/partial_sum_1_ca
          final_index_req_924_symbol <= partial_sum_1_ca_923_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_add_indices/final_index_req
          array_obj_ref_81_offset_inst_req_0 <= final_index_req_924_symbol; -- link to DP
          final_index_ack_925_symbol <= array_obj_ref_81_offset_inst_ack_0; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_add_indices/final_index_ack
          Xexit_919_symbol <= final_index_ack_925_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_add_indices/$exit
          array_obj_ref_81_add_indices_917_symbol <= Xexit_919_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_add_indices
        array_obj_ref_81_base_plus_offset_926: Block -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_base_plus_offset 
          signal array_obj_ref_81_base_plus_offset_926_start: Boolean;
          signal Xentry_927_symbol: Boolean;
          signal Xexit_928_symbol: Boolean;
          signal sum_rename_req_929_symbol : Boolean;
          signal sum_rename_ack_930_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_81_base_plus_offset_926_start <= array_obj_ref_81_offset_calculated_901_symbol; -- control passed to block
          Xentry_927_symbol  <= array_obj_ref_81_base_plus_offset_926_start; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_base_plus_offset/$entry
          sum_rename_req_929_symbol <= Xentry_927_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_base_plus_offset/sum_rename_req
          array_obj_ref_81_root_address_inst_req_0 <= sum_rename_req_929_symbol; -- link to DP
          sum_rename_ack_930_symbol <= array_obj_ref_81_root_address_inst_ack_0; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_base_plus_offset/sum_rename_ack
          Xexit_928_symbol <= sum_rename_ack_930_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_base_plus_offset/$exit
          array_obj_ref_81_base_plus_offset_926_symbol <= Xexit_928_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/array_obj_ref_81_base_plus_offset
        addr_of_82_complete_931: Block -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_82_complete 
          signal addr_of_82_complete_931_start: Boolean;
          signal Xentry_932_symbol: Boolean;
          signal Xexit_933_symbol: Boolean;
          signal final_reg_req_934_symbol : Boolean;
          signal final_reg_ack_935_symbol : Boolean;
          -- 
        begin -- 
          addr_of_82_complete_931_start <= addr_of_82_active_x_x897_symbol; -- control passed to block
          Xentry_932_symbol  <= addr_of_82_complete_931_start; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_82_complete/$entry
          final_reg_req_934_symbol <= Xentry_932_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_82_complete/final_reg_req
          addr_of_82_final_reg_req_0 <= final_reg_req_934_symbol; -- link to DP
          final_reg_ack_935_symbol <= addr_of_82_final_reg_ack_0; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_82_complete/final_reg_ack
          Xexit_933_symbol <= final_reg_ack_935_symbol; -- transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_82_complete/$exit
          addr_of_82_complete_931_symbol <= Xexit_933_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/addr_of_82_complete
        Xexit_853_block : Block -- non-trivial join transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/$exit 
          signal Xexit_853_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_853_predecessors(0) <= assign_stmt_77_completed_x_x855_symbol;
          Xexit_853_predecessors(1) <= assign_stmt_83_completed_x_x896_symbol;
          Xexit_853_join: join -- 
            port map( -- 
              preds => Xexit_853_predecessors,
              symbol_out => Xexit_853_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83/$exit
        assign_stmt_77_to_assign_stmt_83_851_symbol <= Xexit_853_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_45/assign_stmt_77_to_assign_stmt_83
      call_stmt_87_936: Block -- branch_block_stmt_45/call_stmt_87 
        signal call_stmt_87_936_start: Boolean;
        signal Xentry_937_symbol: Boolean;
        signal Xexit_938_symbol: Boolean;
        signal simple_obj_ref_84_complete_939_symbol : Boolean;
        signal simple_obj_ref_85_complete_940_symbol : Boolean;
        signal simple_obj_ref_86_complete_941_symbol : Boolean;
        signal call_stmt_87_active_x_x942_symbol : Boolean;
        signal call_stmt_87_in_progress_943_symbol : Boolean;
        signal call_stmt_87_start_944_symbol : Boolean;
        signal call_stmt_87_complete_949_symbol : Boolean;
        signal call_stmt_87_call_complete_954_symbol : Boolean;
        signal call_stmt_87_completed_x_x955_symbol : Boolean;
        -- 
      begin -- 
        call_stmt_87_936_start <= call_stmt_87_x_xentry_x_xx_x799_symbol; -- control passed to block
        Xentry_937_symbol  <= call_stmt_87_936_start; -- transition branch_block_stmt_45/call_stmt_87/$entry
        simple_obj_ref_84_complete_939_symbol <= Xentry_937_symbol; -- transition branch_block_stmt_45/call_stmt_87/simple_obj_ref_84_complete
        simple_obj_ref_85_complete_940_symbol <= Xentry_937_symbol; -- transition branch_block_stmt_45/call_stmt_87/simple_obj_ref_85_complete
        simple_obj_ref_86_complete_941_symbol <= Xentry_937_symbol; -- transition branch_block_stmt_45/call_stmt_87/simple_obj_ref_86_complete
        call_stmt_87_active_x_x942_block : Block -- non-trivial join transition branch_block_stmt_45/call_stmt_87/call_stmt_87_active_ 
          signal call_stmt_87_active_x_x942_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          call_stmt_87_active_x_x942_predecessors(0) <= simple_obj_ref_84_complete_939_symbol;
          call_stmt_87_active_x_x942_predecessors(1) <= simple_obj_ref_85_complete_940_symbol;
          call_stmt_87_active_x_x942_predecessors(2) <= simple_obj_ref_86_complete_941_symbol;
          call_stmt_87_active_x_x942_join: join -- 
            port map( -- 
              preds => call_stmt_87_active_x_x942_predecessors,
              symbol_out => call_stmt_87_active_x_x942_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_45/call_stmt_87/call_stmt_87_active_
        call_stmt_87_in_progress_943_symbol <= call_stmt_87_start_944_symbol; -- transition branch_block_stmt_45/call_stmt_87/call_stmt_87_in_progress
        call_stmt_87_start_944: Block -- branch_block_stmt_45/call_stmt_87/call_stmt_87_start 
          signal call_stmt_87_start_944_start: Boolean;
          signal Xentry_945_symbol: Boolean;
          signal Xexit_946_symbol: Boolean;
          signal crr_947_symbol : Boolean;
          signal cra_948_symbol : Boolean;
          -- 
        begin -- 
          call_stmt_87_start_944_start <= call_stmt_87_active_x_x942_symbol; -- control passed to block
          Xentry_945_symbol  <= call_stmt_87_start_944_start; -- transition branch_block_stmt_45/call_stmt_87/call_stmt_87_start/$entry
          crr_947_symbol <= Xentry_945_symbol; -- transition branch_block_stmt_45/call_stmt_87/call_stmt_87_start/crr
          call_stmt_87_call_req_0 <= crr_947_symbol; -- link to DP
          cra_948_symbol <= call_stmt_87_call_ack_0; -- transition branch_block_stmt_45/call_stmt_87/call_stmt_87_start/cra
          Xexit_946_symbol <= cra_948_symbol; -- transition branch_block_stmt_45/call_stmt_87/call_stmt_87_start/$exit
          call_stmt_87_start_944_symbol <= Xexit_946_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/call_stmt_87/call_stmt_87_start
        call_stmt_87_complete_949: Block -- branch_block_stmt_45/call_stmt_87/call_stmt_87_complete 
          signal call_stmt_87_complete_949_start: Boolean;
          signal Xentry_950_symbol: Boolean;
          signal Xexit_951_symbol: Boolean;
          signal ccr_952_symbol : Boolean;
          signal cca_953_symbol : Boolean;
          -- 
        begin -- 
          call_stmt_87_complete_949_start <= call_stmt_87_in_progress_943_symbol; -- control passed to block
          Xentry_950_symbol  <= call_stmt_87_complete_949_start; -- transition branch_block_stmt_45/call_stmt_87/call_stmt_87_complete/$entry
          ccr_952_symbol <= Xentry_950_symbol; -- transition branch_block_stmt_45/call_stmt_87/call_stmt_87_complete/ccr
          call_stmt_87_call_req_1 <= ccr_952_symbol; -- link to DP
          cca_953_symbol <= call_stmt_87_call_ack_1; -- transition branch_block_stmt_45/call_stmt_87/call_stmt_87_complete/cca
          Xexit_951_symbol <= cca_953_symbol; -- transition branch_block_stmt_45/call_stmt_87/call_stmt_87_complete/$exit
          call_stmt_87_complete_949_symbol <= Xexit_951_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/call_stmt_87/call_stmt_87_complete
        call_stmt_87_call_complete_954_symbol <= call_stmt_87_complete_949_symbol; -- transition branch_block_stmt_45/call_stmt_87/call_stmt_87_call_complete
        call_stmt_87_completed_x_x955_symbol <= call_stmt_87_call_complete_954_symbol; -- transition branch_block_stmt_45/call_stmt_87/call_stmt_87_completed_
        Xexit_938_symbol <= call_stmt_87_completed_x_x955_symbol; -- transition branch_block_stmt_45/call_stmt_87/$exit
        call_stmt_87_936_symbol <= Xexit_938_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_45/call_stmt_87
      bb_0_bb_1_PhiReq_956: Block -- branch_block_stmt_45/bb_0_bb_1_PhiReq 
        signal bb_0_bb_1_PhiReq_956_start: Boolean;
        signal Xentry_957_symbol: Boolean;
        signal Xexit_958_symbol: Boolean;
        signal phi_stmt_52_959_symbol : Boolean;
        -- 
      begin -- 
        bb_0_bb_1_PhiReq_956_start <= bb_0_bb_1_789_symbol; -- control passed to block
        Xentry_957_symbol  <= bb_0_bb_1_PhiReq_956_start; -- transition branch_block_stmt_45/bb_0_bb_1_PhiReq/$entry
        phi_stmt_52_959: Block -- branch_block_stmt_45/bb_0_bb_1_PhiReq/phi_stmt_52 
          signal phi_stmt_52_959_start: Boolean;
          signal Xentry_960_symbol: Boolean;
          signal Xexit_961_symbol: Boolean;
          signal type_cast_58_962_symbol : Boolean;
          signal phi_stmt_52_req_967_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_52_959_start <= Xentry_957_symbol; -- control passed to block
          Xentry_960_symbol  <= phi_stmt_52_959_start; -- transition branch_block_stmt_45/bb_0_bb_1_PhiReq/phi_stmt_52/$entry
          type_cast_58_962: Block -- branch_block_stmt_45/bb_0_bb_1_PhiReq/phi_stmt_52/type_cast_58 
            signal type_cast_58_962_start: Boolean;
            signal Xentry_963_symbol: Boolean;
            signal Xexit_964_symbol: Boolean;
            signal req_965_symbol : Boolean;
            signal ack_966_symbol : Boolean;
            -- 
          begin -- 
            type_cast_58_962_start <= Xentry_960_symbol; -- control passed to block
            Xentry_963_symbol  <= type_cast_58_962_start; -- transition branch_block_stmt_45/bb_0_bb_1_PhiReq/phi_stmt_52/type_cast_58/$entry
            req_965_symbol <= Xentry_963_symbol; -- transition branch_block_stmt_45/bb_0_bb_1_PhiReq/phi_stmt_52/type_cast_58/req
            ack_966_symbol <= req_965_symbol; -- transition branch_block_stmt_45/bb_0_bb_1_PhiReq/phi_stmt_52/type_cast_58/ack
            Xexit_964_symbol <= ack_966_symbol; -- transition branch_block_stmt_45/bb_0_bb_1_PhiReq/phi_stmt_52/type_cast_58/$exit
            type_cast_58_962_symbol <= Xexit_964_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_45/bb_0_bb_1_PhiReq/phi_stmt_52/type_cast_58
          phi_stmt_52_req_967_symbol <= type_cast_58_962_symbol; -- transition branch_block_stmt_45/bb_0_bb_1_PhiReq/phi_stmt_52/phi_stmt_52_req
          phi_stmt_52_req_0 <= phi_stmt_52_req_967_symbol; -- link to DP
          Xexit_961_symbol <= phi_stmt_52_req_967_symbol; -- transition branch_block_stmt_45/bb_0_bb_1_PhiReq/phi_stmt_52/$exit
          phi_stmt_52_959_symbol <= Xexit_961_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/bb_0_bb_1_PhiReq/phi_stmt_52
        Xexit_958_symbol <= phi_stmt_52_959_symbol; -- transition branch_block_stmt_45/bb_0_bb_1_PhiReq/$exit
        bb_0_bb_1_PhiReq_956_symbol <= Xexit_958_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_45/bb_0_bb_1_PhiReq
      bb_1_bb_1_PhiReq_968: Block -- branch_block_stmt_45/bb_1_bb_1_PhiReq 
        signal bb_1_bb_1_PhiReq_968_start: Boolean;
        signal Xentry_969_symbol: Boolean;
        signal Xexit_970_symbol: Boolean;
        signal phi_stmt_52_971_symbol : Boolean;
        -- 
      begin -- 
        bb_1_bb_1_PhiReq_968_start <= bb_1_bb_1_801_symbol; -- control passed to block
        Xentry_969_symbol  <= bb_1_bb_1_PhiReq_968_start; -- transition branch_block_stmt_45/bb_1_bb_1_PhiReq/$entry
        phi_stmt_52_971: Block -- branch_block_stmt_45/bb_1_bb_1_PhiReq/phi_stmt_52 
          signal phi_stmt_52_971_start: Boolean;
          signal Xentry_972_symbol: Boolean;
          signal Xexit_973_symbol: Boolean;
          signal type_cast_58_974_symbol : Boolean;
          signal phi_stmt_52_req_979_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_52_971_start <= Xentry_969_symbol; -- control passed to block
          Xentry_972_symbol  <= phi_stmt_52_971_start; -- transition branch_block_stmt_45/bb_1_bb_1_PhiReq/phi_stmt_52/$entry
          type_cast_58_974: Block -- branch_block_stmt_45/bb_1_bb_1_PhiReq/phi_stmt_52/type_cast_58 
            signal type_cast_58_974_start: Boolean;
            signal Xentry_975_symbol: Boolean;
            signal Xexit_976_symbol: Boolean;
            signal req_977_symbol : Boolean;
            signal ack_978_symbol : Boolean;
            -- 
          begin -- 
            type_cast_58_974_start <= Xentry_972_symbol; -- control passed to block
            Xentry_975_symbol  <= type_cast_58_974_start; -- transition branch_block_stmt_45/bb_1_bb_1_PhiReq/phi_stmt_52/type_cast_58/$entry
            req_977_symbol <= Xentry_975_symbol; -- transition branch_block_stmt_45/bb_1_bb_1_PhiReq/phi_stmt_52/type_cast_58/req
            type_cast_58_inst_req_0 <= req_977_symbol; -- link to DP
            ack_978_symbol <= type_cast_58_inst_ack_0; -- transition branch_block_stmt_45/bb_1_bb_1_PhiReq/phi_stmt_52/type_cast_58/ack
            Xexit_976_symbol <= ack_978_symbol; -- transition branch_block_stmt_45/bb_1_bb_1_PhiReq/phi_stmt_52/type_cast_58/$exit
            type_cast_58_974_symbol <= Xexit_976_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_45/bb_1_bb_1_PhiReq/phi_stmt_52/type_cast_58
          phi_stmt_52_req_979_symbol <= type_cast_58_974_symbol; -- transition branch_block_stmt_45/bb_1_bb_1_PhiReq/phi_stmt_52/phi_stmt_52_req
          phi_stmt_52_req_1 <= phi_stmt_52_req_979_symbol; -- link to DP
          Xexit_973_symbol <= phi_stmt_52_req_979_symbol; -- transition branch_block_stmt_45/bb_1_bb_1_PhiReq/phi_stmt_52/$exit
          phi_stmt_52_971_symbol <= Xexit_973_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_45/bb_1_bb_1_PhiReq/phi_stmt_52
        Xexit_970_symbol <= phi_stmt_52_971_symbol; -- transition branch_block_stmt_45/bb_1_bb_1_PhiReq/$exit
        bb_1_bb_1_PhiReq_968_symbol <= Xexit_970_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_45/bb_1_bb_1_PhiReq
      merge_stmt_51_PhiReqMerge_980_symbol  <=  bb_0_bb_1_PhiReq_956_symbol or bb_1_bb_1_PhiReq_968_symbol; -- place branch_block_stmt_45/merge_stmt_51_PhiReqMerge (optimized away) 
      merge_stmt_51_PhiAck_981: Block -- branch_block_stmt_45/merge_stmt_51_PhiAck 
        signal merge_stmt_51_PhiAck_981_start: Boolean;
        signal Xentry_982_symbol: Boolean;
        signal Xexit_983_symbol: Boolean;
        signal phi_stmt_52_ack_984_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_51_PhiAck_981_start <= merge_stmt_51_PhiReqMerge_980_symbol; -- control passed to block
        Xentry_982_symbol  <= merge_stmt_51_PhiAck_981_start; -- transition branch_block_stmt_45/merge_stmt_51_PhiAck/$entry
        phi_stmt_52_ack_984_symbol <= phi_stmt_52_ack_0; -- transition branch_block_stmt_45/merge_stmt_51_PhiAck/phi_stmt_52_ack
        Xexit_983_symbol <= phi_stmt_52_ack_984_symbol; -- transition branch_block_stmt_45/merge_stmt_51_PhiAck/$exit
        merge_stmt_51_PhiAck_981_symbol <= Xexit_983_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_45/merge_stmt_51_PhiAck
      Xexit_784_symbol <= branch_block_stmt_45_x_xexit_x_xx_x786_symbol; -- transition branch_block_stmt_45/$exit
      branch_block_stmt_45_782_symbol <= Xexit_784_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_45
    Xexit_781_symbol <= branch_block_stmt_45_782_symbol; -- transition $exit
    fin  <=  '1' when Xexit_781_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal array_obj_ref_75_constant_part_of_offset : std_logic_vector(9 downto 0);
    signal array_obj_ref_75_final_offset : std_logic_vector(9 downto 0);
    signal array_obj_ref_75_index_partial_sum_1 : std_logic_vector(9 downto 0);
    signal array_obj_ref_75_offset_scale_factor_0 : std_logic_vector(9 downto 0);
    signal array_obj_ref_75_offset_scale_factor_1 : std_logic_vector(9 downto 0);
    signal array_obj_ref_75_resized_base_address : std_logic_vector(9 downto 0);
    signal array_obj_ref_75_root_address : std_logic_vector(9 downto 0);
    signal array_obj_ref_81_constant_part_of_offset : std_logic_vector(9 downto 0);
    signal array_obj_ref_81_final_offset : std_logic_vector(9 downto 0);
    signal array_obj_ref_81_index_partial_sum_1 : std_logic_vector(9 downto 0);
    signal array_obj_ref_81_offset_scale_factor_0 : std_logic_vector(9 downto 0);
    signal array_obj_ref_81_offset_scale_factor_1 : std_logic_vector(9 downto 0);
    signal array_obj_ref_81_resized_base_address : std_logic_vector(9 downto 0);
    signal array_obj_ref_81_root_address : std_logic_vector(9 downto 0);
    signal free_indexx_x0_52 : std_logic_vector(31 downto 0);
    signal iNsTr_4_62 : std_logic_vector(31 downto 0);
    signal iNsTr_5_68 : std_logic_vector(31 downto 0);
    signal iNsTr_8_77 : std_logic_vector(31 downto 0);
    signal iNsTr_9_83 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_73_resized : std_logic_vector(9 downto 0);
    signal simple_obj_ref_73_scaled : std_logic_vector(9 downto 0);
    signal simple_obj_ref_79_resized : std_logic_vector(9 downto 0);
    signal simple_obj_ref_79_scaled : std_logic_vector(9 downto 0);
    signal type_cast_48_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_56_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_58_wire : std_logic_vector(31 downto 0);
    signal type_cast_65_wire_constant : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    array_obj_ref_75_constant_part_of_offset <= "0000000000";
    array_obj_ref_75_offset_scale_factor_0 <= "0100000000";
    array_obj_ref_75_offset_scale_factor_1 <= "0000000001";
    array_obj_ref_75_resized_base_address <= "0000000000";
    array_obj_ref_81_constant_part_of_offset <= "0000000000";
    array_obj_ref_81_offset_scale_factor_0 <= "0100000000";
    array_obj_ref_81_offset_scale_factor_1 <= "0000000001";
    array_obj_ref_81_resized_base_address <= "0000000000";
    type_cast_48_wire_constant <= "00000000000000000000000000000000";
    type_cast_56_wire_constant <= "00000000000000000000000000000000";
    type_cast_65_wire_constant <= "00000000000000000000000000000001";
    phi_stmt_52: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_56_wire_constant & type_cast_58_wire;
      req <= phi_stmt_52_req_0 & phi_stmt_52_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_52_ack_0,
          idata => idata,
          odata => free_indexx_x0_52,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_52
    addr_of_76_final_reg: RegisterBase --
      generic map(in_data_width => 10,out_data_width => 32, flow_through => false ) 
      port map( din => array_obj_ref_75_root_address, dout => iNsTr_8_77, req => addr_of_76_final_reg_req_0, ack => addr_of_76_final_reg_ack_0, clk => clk, reset => reset); -- 
    addr_of_82_final_reg: RegisterBase --
      generic map(in_data_width => 10,out_data_width => 32, flow_through => false ) 
      port map( din => array_obj_ref_81_root_address, dout => iNsTr_9_83, req => addr_of_82_final_reg_req_0, ack => addr_of_82_final_reg_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_75_index_0_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 10, flow_through => true ) 
      port map( din => free_indexx_x0_52, dout => simple_obj_ref_73_resized, req => array_obj_ref_75_index_0_resize_req_0, ack => array_obj_ref_75_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_75_offset_inst: RegisterBase --
      generic map(in_data_width => 10,out_data_width => 10, flow_through => true ) 
      port map( din => array_obj_ref_75_index_partial_sum_1, dout => array_obj_ref_75_final_offset, req => array_obj_ref_75_offset_inst_req_0, ack => array_obj_ref_75_offset_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_81_index_0_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 10, flow_through => true ) 
      port map( din => free_indexx_x0_52, dout => simple_obj_ref_79_resized, req => array_obj_ref_81_index_0_resize_req_0, ack => array_obj_ref_81_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_81_offset_inst: RegisterBase --
      generic map(in_data_width => 10,out_data_width => 10, flow_through => true ) 
      port map( din => array_obj_ref_81_index_partial_sum_1, dout => array_obj_ref_81_final_offset, req => array_obj_ref_81_offset_inst_req_0, ack => array_obj_ref_81_offset_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_58_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => iNsTr_5_68, dout => type_cast_58_wire, req => type_cast_58_inst_req_0, ack => type_cast_58_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_75_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(9 downto 0); --
    begin -- 
      array_obj_ref_75_root_address_inst_ack_0 <= array_obj_ref_75_root_address_inst_req_0;
      aggregated_sig <= array_obj_ref_75_final_offset;
      array_obj_ref_75_root_address <= aggregated_sig(9 downto 0);
      --
    end Block;
    array_obj_ref_81_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(9 downto 0); --
    begin -- 
      array_obj_ref_81_root_address_inst_ack_0 <= array_obj_ref_81_root_address_inst_req_0;
      aggregated_sig <= array_obj_ref_81_final_offset;
      array_obj_ref_81_root_address <= aggregated_sig(9 downto 0);
      --
    end Block;
    -- shared split operator group (0) : array_obj_ref_75_index_0_scale 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= simple_obj_ref_73_resized;
      simple_obj_ref_73_scaled <= data_out(9 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntMul",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 10,
          constant_operand => "0100000000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => array_obj_ref_75_index_0_scale_req_0,
          ackL => array_obj_ref_75_index_0_scale_ack_0,
          reqR => array_obj_ref_75_index_0_scale_req_1,
          ackR => array_obj_ref_75_index_0_scale_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : array_obj_ref_75_index_sum_1 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= simple_obj_ref_73_scaled;
      array_obj_ref_75_index_partial_sum_1 <= data_out(9 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 10,
          constant_operand => "0000000000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => array_obj_ref_75_index_sum_1_req_0,
          ackL => array_obj_ref_75_index_sum_1_ack_0,
          reqR => array_obj_ref_75_index_sum_1_req_1,
          ackR => array_obj_ref_75_index_sum_1_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : array_obj_ref_81_index_0_scale 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= simple_obj_ref_79_resized;
      simple_obj_ref_79_scaled <= data_out(9 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntMul",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 10,
          constant_operand => "0100000000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => array_obj_ref_81_index_0_scale_req_0,
          ackL => array_obj_ref_81_index_0_scale_ack_0,
          reqR => array_obj_ref_81_index_0_scale_req_1,
          ackR => array_obj_ref_81_index_0_scale_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : array_obj_ref_81_index_sum_1 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= simple_obj_ref_79_scaled;
      array_obj_ref_81_index_partial_sum_1 <= data_out(9 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 10,
          constant_operand => "0000000000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => array_obj_ref_81_index_sum_1_req_0,
          ackL => array_obj_ref_81_index_sum_1_ack_0,
          reqR => array_obj_ref_81_index_sum_1_req_1,
          ackR => array_obj_ref_81_index_sum_1_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : binary_67_inst 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= type_cast_65_wire_constant & free_indexx_x0_52;
      iNsTr_5_68 <= data_out(31 downto 0);
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
          reqL => binary_67_inst_req_0,
          ackL => binary_67_inst_ack_0,
          reqR => binary_67_inst_req_1,
          ackR => binary_67_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared inport operator group (0) : simple_obj_ref_61_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_61_inst_req_0;
      simple_obj_ref_61_inst_ack_0 <= ack(0);
      iNsTr_4_62 <= data_out(31 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => true)
        port map (-- 
          req => req , 
          ack => ack , 
          data => data_out, 
          oreq => send_msg_pipe_read_req(0),
          oack => send_msg_pipe_read_ack(0),
          odata => send_msg_pipe_read_data(31 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared outport operator group (0) : simple_obj_ref_46_inst simple_obj_ref_69_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      req(1) <= simple_obj_ref_46_inst_req_0;
      req(0) <= simple_obj_ref_69_inst_req_0;
      simple_obj_ref_46_inst_ack_0 <= ack(1);
      simple_obj_ref_69_inst_ack_0 <= ack(0);
      data_in <= type_cast_48_wire_constant & iNsTr_5_68;
      outport: OutputPort -- 
        generic map ( data_width => 32,  num_reqs => 2,  no_arbitration => true)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => free_index_pipe_pipe_write_req(0),
          oack => free_index_pipe_pipe_write_ack(0),
          odata => free_index_pipe_pipe_write_data(31 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    -- shared call operator group (0) : call_stmt_87_call 
    CallGroup0: Block -- 
      signal data_in: std_logic_vector(95 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= call_stmt_87_call_req_0;
      call_stmt_87_call_ack_0 <= ackL(0);
      reqR(0) <= call_stmt_87_call_req_1;
      call_stmt_87_call_ack_1 <= ackR(0);
      data_in <= iNsTr_8_77 & iNsTr_9_83 & iNsTr_4_62;
      CallReq: InputMuxBase -- 
        generic map (  iwidth => 96, owidth => 96, twidth => 1, nreqs => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          reqR => remove_packet_call_reqs(0),
          ackR => remove_packet_call_acks(0),
          dataR => remove_packet_call_data(95 downto 0),
          tagR => remove_packet_call_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      CallComplete: OutputDemuxBaseNoData -- 
        generic map ( 
        twidth => 1, nreqs => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          reqL => remove_packet_return_acks(0), -- cross-over
          ackL => remove_packet_return_reqs(0), -- cross-over
          tagL => remove_packet_return_tag(0 downto 0),
          clk => clk,
          reset => reset -- 
        ); -- 
      -- 
    end Block; -- call group 0
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
entity store_packet is -- 
  port ( -- 
    ctrlptr : in  std_logic_vector(31 downto 0);
    dataptr : in  std_logic_vector(31 downto 0);
    pktlength : out  std_logic_vector(31 downto 0);
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    memory_space_1_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_1_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_sr_addr : out  std_logic_vector(9 downto 0);
    memory_space_1_sr_data : out  std_logic_vector(7 downto 0);
    memory_space_1_sr_tag :  out  std_logic_vector(0 downto 0);
    memory_space_1_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_1_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_sc_tag :  in  std_logic_vector(0 downto 0);
    memory_space_2_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_2_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_sr_addr : out  std_logic_vector(9 downto 0);
    memory_space_2_sr_data : out  std_logic_vector(63 downto 0);
    memory_space_2_sr_tag :  out  std_logic_vector(0 downto 0);
    memory_space_2_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_2_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_sc_tag :  in  std_logic_vector(0 downto 0);
    in_ctrl_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_ctrl_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_ctrl_pipe_read_data : in   std_logic_vector(7 downto 0);
    in_data_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_data_pipe_read_data : in   std_logic_vector(63 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity store_packet;
architecture Default of store_packet is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal simple_obj_ref_111_inst_req_0 : boolean;
  signal simple_obj_ref_111_inst_ack_0 : boolean;
  signal array_obj_ref_118_final_reg_req_0 : boolean;
  signal simple_obj_ref_114_inst_req_0 : boolean;
  signal simple_obj_ref_114_inst_ack_0 : boolean;
  signal array_obj_ref_118_index_0_resize_req_0 : boolean;
  signal array_obj_ref_118_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_118_index_0_rename_req_0 : boolean;
  signal array_obj_ref_118_index_0_rename_ack_0 : boolean;
  signal array_obj_ref_118_offset_inst_req_0 : boolean;
  signal array_obj_ref_118_offset_inst_ack_0 : boolean;
  signal array_obj_ref_118_base_resize_req_0 : boolean;
  signal array_obj_ref_118_base_resize_ack_0 : boolean;
  signal array_obj_ref_118_root_address_inst_req_0 : boolean;
  signal array_obj_ref_118_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_118_root_address_inst_req_1 : boolean;
  signal array_obj_ref_118_root_address_inst_ack_1 : boolean;
  signal ptr_deref_131_store_0_req_0 : boolean;
  signal ptr_deref_131_store_0_ack_0 : boolean;
  signal array_obj_ref_118_final_reg_ack_0 : boolean;
  signal array_obj_ref_122_index_0_resize_req_0 : boolean;
  signal array_obj_ref_122_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_122_index_0_rename_req_0 : boolean;
  signal array_obj_ref_122_index_0_rename_ack_0 : boolean;
  signal array_obj_ref_122_offset_inst_req_0 : boolean;
  signal array_obj_ref_122_offset_inst_ack_0 : boolean;
  signal array_obj_ref_122_base_resize_req_0 : boolean;
  signal array_obj_ref_122_base_resize_ack_0 : boolean;
  signal array_obj_ref_122_root_address_inst_req_0 : boolean;
  signal array_obj_ref_122_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_122_root_address_inst_req_1 : boolean;
  signal array_obj_ref_122_root_address_inst_ack_1 : boolean;
  signal array_obj_ref_122_final_reg_req_0 : boolean;
  signal array_obj_ref_122_final_reg_ack_0 : boolean;
  signal binary_127_inst_req_0 : boolean;
  signal binary_127_inst_ack_0 : boolean;
  signal binary_127_inst_req_1 : boolean;
  signal binary_127_inst_ack_1 : boolean;
  signal ptr_deref_131_base_resize_req_0 : boolean;
  signal ptr_deref_131_base_resize_ack_0 : boolean;
  signal ptr_deref_131_root_address_inst_req_0 : boolean;
  signal ptr_deref_131_root_address_inst_ack_0 : boolean;
  signal ptr_deref_131_addr_0_req_0 : boolean;
  signal ptr_deref_131_addr_0_ack_0 : boolean;
  signal ptr_deref_131_gather_scatter_req_0 : boolean;
  signal ptr_deref_131_gather_scatter_ack_0 : boolean;
  signal ptr_deref_131_store_0_req_1 : boolean;
  signal ptr_deref_131_store_0_ack_1 : boolean;
  signal ptr_deref_135_base_resize_req_0 : boolean;
  signal ptr_deref_135_base_resize_ack_0 : boolean;
  signal ptr_deref_135_root_address_inst_req_0 : boolean;
  signal ptr_deref_135_root_address_inst_ack_0 : boolean;
  signal ptr_deref_135_addr_0_req_0 : boolean;
  signal ptr_deref_135_addr_0_ack_0 : boolean;
  signal ptr_deref_135_gather_scatter_req_0 : boolean;
  signal ptr_deref_135_gather_scatter_ack_0 : boolean;
  signal ptr_deref_135_store_0_req_0 : boolean;
  signal ptr_deref_135_store_0_ack_0 : boolean;
  signal ptr_deref_135_store_0_req_1 : boolean;
  signal ptr_deref_135_store_0_ack_1 : boolean;
  signal simple_obj_ref_138_inst_req_0 : boolean;
  signal simple_obj_ref_138_inst_ack_0 : boolean;
  signal switch_stmt_141_branch_default_req_0 : boolean;
  signal switch_stmt_141_select_expr_0_req_0 : boolean;
  signal switch_stmt_141_select_expr_0_ack_0 : boolean;
  signal switch_stmt_141_select_expr_0_req_1 : boolean;
  signal switch_stmt_141_select_expr_0_ack_1 : boolean;
  signal switch_stmt_141_branch_0_req_0 : boolean;
  signal switch_stmt_141_select_expr_1_req_0 : boolean;
  signal switch_stmt_141_select_expr_1_ack_0 : boolean;
  signal switch_stmt_141_select_expr_1_req_1 : boolean;
  signal switch_stmt_141_select_expr_1_ack_1 : boolean;
  signal switch_stmt_141_branch_1_req_0 : boolean;
  signal switch_stmt_141_branch_0_ack_1 : boolean;
  signal switch_stmt_141_branch_1_ack_1 : boolean;
  signal switch_stmt_141_branch_default_ack_0 : boolean;
  signal phi_stmt_103_req_0 : boolean;
  signal phi_stmt_103_req_1 : boolean;
  signal phi_stmt_103_ack_0 : boolean;
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
  store_packet_CP_0: Block -- control-path 
    signal store_packet_CP_0_start: Boolean;
    signal Xentry_1_symbol: Boolean;
    signal Xexit_2_symbol: Boolean;
    signal branch_block_stmt_101_3_symbol : Boolean;
    -- 
  begin -- 
    store_packet_CP_0_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_1_symbol  <= store_packet_CP_0_start; -- transition $entry
    branch_block_stmt_101_3: Block -- branch_block_stmt_101 
      signal branch_block_stmt_101_3_start: Boolean;
      signal Xentry_4_symbol: Boolean;
      signal Xexit_5_symbol: Boolean;
      signal branch_block_stmt_101_x_xentry_x_xx_x6_symbol : Boolean;
      signal branch_block_stmt_101_x_xexit_x_xx_x7_symbol : Boolean;
      signal merge_stmt_102_x_xentry_x_xx_x8_symbol : Boolean;
      signal merge_stmt_102_x_xexit_x_xx_x9_symbol : Boolean;
      signal parallel_block_stmt_109_x_xentry_x_xx_x10_symbol : Boolean;
      signal parallel_block_stmt_109_x_xexit_x_xx_x11_symbol : Boolean;
      signal assign_stmt_133_to_assign_stmt_140_x_xentry_x_xx_x12_symbol : Boolean;
      signal assign_stmt_133_to_assign_stmt_140_x_xexit_x_xx_x13_symbol : Boolean;
      signal switch_stmt_141_x_xentry_x_xx_x14_symbol : Boolean;
      signal switch_stmt_141_x_xexit_x_xx_x15_symbol : Boolean;
      signal parallel_block_stmt_109_16_symbol : Boolean;
      signal assign_stmt_133_to_assign_stmt_140_152_symbol : Boolean;
      signal switch_stmt_141_dead_link_261_symbol : Boolean;
      signal switch_stmt_141_x_xcondition_check_place_x_xx_x265_symbol : Boolean;
      signal switch_stmt_141_x_xcondition_check_x_xx_x266_symbol : Boolean;
      signal switch_stmt_141_x_xselect_x_xx_x285_symbol : Boolean;
      signal switch_stmt_141_choice_0_286_symbol : Boolean;
      signal loopback_290_symbol : Boolean;
      signal switch_stmt_141_choice_1_291_symbol : Boolean;
      signal switch_stmt_141_choice_default_295_symbol : Boolean;
      signal switch_stmt_141_choice_default_to_switch_stmt_141_x_xexit_x_xx_x299_symbol : Boolean;
      signal merge_stmt_102_dead_link_300_symbol : Boolean;
      signal merge_stmt_102_x_xentry_x_xx_xPhiReq_304_symbol : Boolean;
      signal loopback_PhiReq_311_symbol : Boolean;
      signal merge_stmt_102_PhiReqMerge_318_symbol : Boolean;
      signal merge_stmt_102_PhiAck_319_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_101_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_101_3_start; -- transition branch_block_stmt_101/$entry
      branch_block_stmt_101_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_101/branch_block_stmt_101__entry__ (optimized away) 
      branch_block_stmt_101_x_xexit_x_xx_x7_symbol  <=  switch_stmt_141_x_xexit_x_xx_x15_symbol; -- place branch_block_stmt_101/branch_block_stmt_101__exit__ (optimized away) 
      merge_stmt_102_x_xentry_x_xx_x8_symbol  <=  branch_block_stmt_101_x_xentry_x_xx_x6_symbol; -- place branch_block_stmt_101/merge_stmt_102__entry__ (optimized away) 
      merge_stmt_102_x_xexit_x_xx_x9_symbol  <=  merge_stmt_102_dead_link_300_symbol or merge_stmt_102_PhiAck_319_symbol; -- place branch_block_stmt_101/merge_stmt_102__exit__ (optimized away) 
      parallel_block_stmt_109_x_xentry_x_xx_x10_symbol  <=  merge_stmt_102_x_xexit_x_xx_x9_symbol; -- place branch_block_stmt_101/parallel_block_stmt_109__entry__ (optimized away) 
      parallel_block_stmt_109_x_xexit_x_xx_x11_symbol  <=  parallel_block_stmt_109_16_symbol; -- place branch_block_stmt_101/parallel_block_stmt_109__exit__ (optimized away) 
      assign_stmt_133_to_assign_stmt_140_x_xentry_x_xx_x12_symbol  <=  parallel_block_stmt_109_x_xexit_x_xx_x11_symbol; -- place branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140__entry__ (optimized away) 
      assign_stmt_133_to_assign_stmt_140_x_xexit_x_xx_x13_symbol  <=  assign_stmt_133_to_assign_stmt_140_152_symbol; -- place branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140__exit__ (optimized away) 
      switch_stmt_141_x_xentry_x_xx_x14_symbol  <=  assign_stmt_133_to_assign_stmt_140_x_xexit_x_xx_x13_symbol; -- place branch_block_stmt_101/switch_stmt_141__entry__ (optimized away) 
      switch_stmt_141_x_xexit_x_xx_x15_symbol  <=  switch_stmt_141_choice_default_to_switch_stmt_141_x_xexit_x_xx_x299_symbol or switch_stmt_141_dead_link_261_symbol; -- place branch_block_stmt_101/switch_stmt_141__exit__ (optimized away) 
      parallel_block_stmt_109_16: Block -- branch_block_stmt_101/parallel_block_stmt_109 
        signal parallel_block_stmt_109_16_start: Boolean;
        signal Xentry_17_symbol: Boolean;
        signal Xexit_18_symbol: Boolean;
        signal assign_stmt_112_19_symbol : Boolean;
        signal assign_stmt_115_30_symbol : Boolean;
        signal assign_stmt_119_41_symbol : Boolean;
        signal assign_stmt_123_89_symbol : Boolean;
        signal assign_stmt_128_137_symbol : Boolean;
        -- 
      begin -- 
        parallel_block_stmt_109_16_start <= parallel_block_stmt_109_x_xentry_x_xx_x10_symbol; -- control passed to block
        Xentry_17_symbol  <= parallel_block_stmt_109_16_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/$entry
        assign_stmt_112_19: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_112 
          signal assign_stmt_112_19_start: Boolean;
          signal Xentry_20_symbol: Boolean;
          signal Xexit_21_symbol: Boolean;
          signal assign_stmt_112_active_x_x22_symbol : Boolean;
          signal assign_stmt_112_completed_x_x23_symbol : Boolean;
          signal simple_obj_ref_111_trigger_x_x24_symbol : Boolean;
          signal simple_obj_ref_111_complete_25_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_112_19_start <= Xentry_17_symbol; -- control passed to block
          Xentry_20_symbol  <= assign_stmt_112_19_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_112/$entry
          assign_stmt_112_active_x_x22_symbol <= simple_obj_ref_111_complete_25_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_112/assign_stmt_112_active_
          assign_stmt_112_completed_x_x23_symbol <= assign_stmt_112_active_x_x22_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_112/assign_stmt_112_completed_
          simple_obj_ref_111_trigger_x_x24_symbol <= Xentry_20_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_112/simple_obj_ref_111_trigger_
          simple_obj_ref_111_complete_25: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_112/simple_obj_ref_111_complete 
            signal simple_obj_ref_111_complete_25_start: Boolean;
            signal Xentry_26_symbol: Boolean;
            signal Xexit_27_symbol: Boolean;
            signal req_28_symbol : Boolean;
            signal ack_29_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_111_complete_25_start <= simple_obj_ref_111_trigger_x_x24_symbol; -- control passed to block
            Xentry_26_symbol  <= simple_obj_ref_111_complete_25_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_112/simple_obj_ref_111_complete/$entry
            req_28_symbol <= Xentry_26_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_112/simple_obj_ref_111_complete/req
            simple_obj_ref_111_inst_req_0 <= req_28_symbol; -- link to DP
            ack_29_symbol <= simple_obj_ref_111_inst_ack_0; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_112/simple_obj_ref_111_complete/ack
            Xexit_27_symbol <= ack_29_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_112/simple_obj_ref_111_complete/$exit
            simple_obj_ref_111_complete_25_symbol <= Xexit_27_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_112/simple_obj_ref_111_complete
          Xexit_21_symbol <= assign_stmt_112_completed_x_x23_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_112/$exit
          assign_stmt_112_19_symbol <= Xexit_21_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_112
        assign_stmt_115_30: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_115 
          signal assign_stmt_115_30_start: Boolean;
          signal Xentry_31_symbol: Boolean;
          signal Xexit_32_symbol: Boolean;
          signal assign_stmt_115_active_x_x33_symbol : Boolean;
          signal assign_stmt_115_completed_x_x34_symbol : Boolean;
          signal simple_obj_ref_114_trigger_x_x35_symbol : Boolean;
          signal simple_obj_ref_114_complete_36_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_115_30_start <= Xentry_17_symbol; -- control passed to block
          Xentry_31_symbol  <= assign_stmt_115_30_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_115/$entry
          assign_stmt_115_active_x_x33_symbol <= simple_obj_ref_114_complete_36_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_115/assign_stmt_115_active_
          assign_stmt_115_completed_x_x34_symbol <= assign_stmt_115_active_x_x33_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_115/assign_stmt_115_completed_
          simple_obj_ref_114_trigger_x_x35_symbol <= Xentry_31_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_115/simple_obj_ref_114_trigger_
          simple_obj_ref_114_complete_36: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_115/simple_obj_ref_114_complete 
            signal simple_obj_ref_114_complete_36_start: Boolean;
            signal Xentry_37_symbol: Boolean;
            signal Xexit_38_symbol: Boolean;
            signal req_39_symbol : Boolean;
            signal ack_40_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_114_complete_36_start <= simple_obj_ref_114_trigger_x_x35_symbol; -- control passed to block
            Xentry_37_symbol  <= simple_obj_ref_114_complete_36_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_115/simple_obj_ref_114_complete/$entry
            req_39_symbol <= Xentry_37_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_115/simple_obj_ref_114_complete/req
            simple_obj_ref_114_inst_req_0 <= req_39_symbol; -- link to DP
            ack_40_symbol <= simple_obj_ref_114_inst_ack_0; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_115/simple_obj_ref_114_complete/ack
            Xexit_38_symbol <= ack_40_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_115/simple_obj_ref_114_complete/$exit
            simple_obj_ref_114_complete_36_symbol <= Xexit_38_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_115/simple_obj_ref_114_complete
          Xexit_32_symbol <= assign_stmt_115_completed_x_x34_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_115/$exit
          assign_stmt_115_30_symbol <= Xexit_32_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_115
        assign_stmt_119_41: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119 
          signal assign_stmt_119_41_start: Boolean;
          signal Xentry_42_symbol: Boolean;
          signal Xexit_43_symbol: Boolean;
          signal assign_stmt_119_active_x_x44_symbol : Boolean;
          signal assign_stmt_119_completed_x_x45_symbol : Boolean;
          signal array_obj_ref_118_trigger_x_x46_symbol : Boolean;
          signal array_obj_ref_118_active_x_x47_symbol : Boolean;
          signal array_obj_ref_118_base_address_calculated_48_symbol : Boolean;
          signal array_obj_ref_118_root_address_calculated_49_symbol : Boolean;
          signal array_obj_ref_118_indices_scaled_50_symbol : Boolean;
          signal array_obj_ref_118_offset_calculated_51_symbol : Boolean;
          signal array_obj_ref_118_index_computed_0_52_symbol : Boolean;
          signal array_obj_ref_118_index_resized_0_53_symbol : Boolean;
          signal simple_obj_ref_117_complete_54_symbol : Boolean;
          signal array_obj_ref_118_index_resize_0_55_symbol : Boolean;
          signal array_obj_ref_118_index_scale_0_60_symbol : Boolean;
          signal array_obj_ref_118_add_indices_65_symbol : Boolean;
          signal array_obj_ref_118_base_address_resized_70_symbol : Boolean;
          signal array_obj_ref_118_base_addr_resize_71_symbol : Boolean;
          signal array_obj_ref_118_base_plus_offset_trigger_76_symbol : Boolean;
          signal array_obj_ref_118_base_plus_offset_77_symbol : Boolean;
          signal array_obj_ref_118_complete_84_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_119_41_start <= Xentry_17_symbol; -- control passed to block
          Xentry_42_symbol  <= assign_stmt_119_41_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/$entry
          assign_stmt_119_active_x_x44_symbol <= array_obj_ref_118_complete_84_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/assign_stmt_119_active_
          assign_stmt_119_completed_x_x45_symbol <= assign_stmt_119_active_x_x44_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/assign_stmt_119_completed_
          array_obj_ref_118_trigger_x_x46_symbol <= Xentry_42_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_trigger_
          array_obj_ref_118_active_x_x47_block : Block -- non-trivial join transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_active_ 
            signal array_obj_ref_118_active_x_x47_predecessors: BooleanArray(1 downto 0);
            -- 
          begin -- 
            array_obj_ref_118_active_x_x47_predecessors(0) <= array_obj_ref_118_trigger_x_x46_symbol;
            array_obj_ref_118_active_x_x47_predecessors(1) <= array_obj_ref_118_root_address_calculated_49_symbol;
            array_obj_ref_118_active_x_x47_join: join -- 
              port map( -- 
                preds => array_obj_ref_118_active_x_x47_predecessors,
                symbol_out => array_obj_ref_118_active_x_x47_symbol,
                clk => clk,
                reset => reset); -- 
            -- 
          end Block; -- non-trivial join transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_active_
          array_obj_ref_118_base_address_calculated_48_symbol <= Xentry_42_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_address_calculated
          array_obj_ref_118_root_address_calculated_49_symbol <= array_obj_ref_118_base_plus_offset_77_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_root_address_calculated
          array_obj_ref_118_indices_scaled_50_symbol <= array_obj_ref_118_index_scale_0_60_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_indices_scaled
          array_obj_ref_118_offset_calculated_51_symbol <= array_obj_ref_118_add_indices_65_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_offset_calculated
          array_obj_ref_118_index_computed_0_52_symbol <= simple_obj_ref_117_complete_54_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_index_computed_0
          array_obj_ref_118_index_resized_0_53_symbol <= array_obj_ref_118_index_resize_0_55_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_index_resized_0
          simple_obj_ref_117_complete_54_symbol <= Xentry_42_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/simple_obj_ref_117_complete
          array_obj_ref_118_index_resize_0_55: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_index_resize_0 
            signal array_obj_ref_118_index_resize_0_55_start: Boolean;
            signal Xentry_56_symbol: Boolean;
            signal Xexit_57_symbol: Boolean;
            signal index_resize_req_58_symbol : Boolean;
            signal index_resize_ack_59_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_118_index_resize_0_55_start <= array_obj_ref_118_index_computed_0_52_symbol; -- control passed to block
            Xentry_56_symbol  <= array_obj_ref_118_index_resize_0_55_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_index_resize_0/$entry
            index_resize_req_58_symbol <= Xentry_56_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_index_resize_0/index_resize_req
            array_obj_ref_118_index_0_resize_req_0 <= index_resize_req_58_symbol; -- link to DP
            index_resize_ack_59_symbol <= array_obj_ref_118_index_0_resize_ack_0; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_index_resize_0/index_resize_ack
            Xexit_57_symbol <= index_resize_ack_59_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_index_resize_0/$exit
            array_obj_ref_118_index_resize_0_55_symbol <= Xexit_57_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_index_resize_0
          array_obj_ref_118_index_scale_0_60: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_index_scale_0 
            signal array_obj_ref_118_index_scale_0_60_start: Boolean;
            signal Xentry_61_symbol: Boolean;
            signal Xexit_62_symbol: Boolean;
            signal scale_rename_req_63_symbol : Boolean;
            signal scale_rename_ack_64_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_118_index_scale_0_60_start <= array_obj_ref_118_index_resized_0_53_symbol; -- control passed to block
            Xentry_61_symbol  <= array_obj_ref_118_index_scale_0_60_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_index_scale_0/$entry
            scale_rename_req_63_symbol <= Xentry_61_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_index_scale_0/scale_rename_req
            array_obj_ref_118_index_0_rename_req_0 <= scale_rename_req_63_symbol; -- link to DP
            scale_rename_ack_64_symbol <= array_obj_ref_118_index_0_rename_ack_0; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_index_scale_0/scale_rename_ack
            Xexit_62_symbol <= scale_rename_ack_64_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_index_scale_0/$exit
            array_obj_ref_118_index_scale_0_60_symbol <= Xexit_62_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_index_scale_0
          array_obj_ref_118_add_indices_65: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_add_indices 
            signal array_obj_ref_118_add_indices_65_start: Boolean;
            signal Xentry_66_symbol: Boolean;
            signal Xexit_67_symbol: Boolean;
            signal final_index_req_68_symbol : Boolean;
            signal final_index_ack_69_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_118_add_indices_65_start <= array_obj_ref_118_indices_scaled_50_symbol; -- control passed to block
            Xentry_66_symbol  <= array_obj_ref_118_add_indices_65_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_add_indices/$entry
            final_index_req_68_symbol <= Xentry_66_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_add_indices/final_index_req
            array_obj_ref_118_offset_inst_req_0 <= final_index_req_68_symbol; -- link to DP
            final_index_ack_69_symbol <= array_obj_ref_118_offset_inst_ack_0; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_add_indices/final_index_ack
            Xexit_67_symbol <= final_index_ack_69_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_add_indices/$exit
            array_obj_ref_118_add_indices_65_symbol <= Xexit_67_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_add_indices
          array_obj_ref_118_base_address_resized_70_symbol <= array_obj_ref_118_base_addr_resize_71_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_address_resized
          array_obj_ref_118_base_addr_resize_71: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_addr_resize 
            signal array_obj_ref_118_base_addr_resize_71_start: Boolean;
            signal Xentry_72_symbol: Boolean;
            signal Xexit_73_symbol: Boolean;
            signal base_resize_req_74_symbol : Boolean;
            signal base_resize_ack_75_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_118_base_addr_resize_71_start <= array_obj_ref_118_base_address_calculated_48_symbol; -- control passed to block
            Xentry_72_symbol  <= array_obj_ref_118_base_addr_resize_71_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_addr_resize/$entry
            base_resize_req_74_symbol <= Xentry_72_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_addr_resize/base_resize_req
            array_obj_ref_118_base_resize_req_0 <= base_resize_req_74_symbol; -- link to DP
            base_resize_ack_75_symbol <= array_obj_ref_118_base_resize_ack_0; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_addr_resize/base_resize_ack
            Xexit_73_symbol <= base_resize_ack_75_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_addr_resize/$exit
            array_obj_ref_118_base_addr_resize_71_symbol <= Xexit_73_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_addr_resize
          array_obj_ref_118_base_plus_offset_trigger_76_block : Block -- non-trivial join transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_plus_offset_trigger 
            signal array_obj_ref_118_base_plus_offset_trigger_76_predecessors: BooleanArray(1 downto 0);
            -- 
          begin -- 
            array_obj_ref_118_base_plus_offset_trigger_76_predecessors(0) <= array_obj_ref_118_base_address_resized_70_symbol;
            array_obj_ref_118_base_plus_offset_trigger_76_predecessors(1) <= array_obj_ref_118_offset_calculated_51_symbol;
            array_obj_ref_118_base_plus_offset_trigger_76_join: join -- 
              port map( -- 
                preds => array_obj_ref_118_base_plus_offset_trigger_76_predecessors,
                symbol_out => array_obj_ref_118_base_plus_offset_trigger_76_symbol,
                clk => clk,
                reset => reset); -- 
            -- 
          end Block; -- non-trivial join transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_plus_offset_trigger
          array_obj_ref_118_base_plus_offset_77: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_plus_offset 
            signal array_obj_ref_118_base_plus_offset_77_start: Boolean;
            signal Xentry_78_symbol: Boolean;
            signal Xexit_79_symbol: Boolean;
            signal plus_base_rr_80_symbol : Boolean;
            signal plus_base_ra_81_symbol : Boolean;
            signal plus_base_cr_82_symbol : Boolean;
            signal plus_base_ca_83_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_118_base_plus_offset_77_start <= array_obj_ref_118_base_plus_offset_trigger_76_symbol; -- control passed to block
            Xentry_78_symbol  <= array_obj_ref_118_base_plus_offset_77_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_plus_offset/$entry
            plus_base_rr_80_symbol <= Xentry_78_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_plus_offset/plus_base_rr
            array_obj_ref_118_root_address_inst_req_0 <= plus_base_rr_80_symbol; -- link to DP
            plus_base_ra_81_symbol <= array_obj_ref_118_root_address_inst_ack_0; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_plus_offset/plus_base_ra
            plus_base_cr_82_symbol <= plus_base_ra_81_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_plus_offset/plus_base_cr
            array_obj_ref_118_root_address_inst_req_1 <= plus_base_cr_82_symbol; -- link to DP
            plus_base_ca_83_symbol <= array_obj_ref_118_root_address_inst_ack_1; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_plus_offset/plus_base_ca
            Xexit_79_symbol <= plus_base_ca_83_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_plus_offset/$exit
            array_obj_ref_118_base_plus_offset_77_symbol <= Xexit_79_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_base_plus_offset
          array_obj_ref_118_complete_84: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_complete 
            signal array_obj_ref_118_complete_84_start: Boolean;
            signal Xentry_85_symbol: Boolean;
            signal Xexit_86_symbol: Boolean;
            signal final_reg_req_87_symbol : Boolean;
            signal final_reg_ack_88_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_118_complete_84_start <= array_obj_ref_118_active_x_x47_symbol; -- control passed to block
            Xentry_85_symbol  <= array_obj_ref_118_complete_84_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_complete/$entry
            final_reg_req_87_symbol <= Xentry_85_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_complete/final_reg_req
            array_obj_ref_118_final_reg_req_0 <= final_reg_req_87_symbol; -- link to DP
            final_reg_ack_88_symbol <= array_obj_ref_118_final_reg_ack_0; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_complete/final_reg_ack
            Xexit_86_symbol <= final_reg_ack_88_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_complete/$exit
            array_obj_ref_118_complete_84_symbol <= Xexit_86_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/array_obj_ref_118_complete
          Xexit_43_symbol <= assign_stmt_119_completed_x_x45_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119/$exit
          assign_stmt_119_41_symbol <= Xexit_43_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_119
        assign_stmt_123_89: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123 
          signal assign_stmt_123_89_start: Boolean;
          signal Xentry_90_symbol: Boolean;
          signal Xexit_91_symbol: Boolean;
          signal assign_stmt_123_active_x_x92_symbol : Boolean;
          signal assign_stmt_123_completed_x_x93_symbol : Boolean;
          signal array_obj_ref_122_trigger_x_x94_symbol : Boolean;
          signal array_obj_ref_122_active_x_x95_symbol : Boolean;
          signal array_obj_ref_122_base_address_calculated_96_symbol : Boolean;
          signal array_obj_ref_122_root_address_calculated_97_symbol : Boolean;
          signal array_obj_ref_122_indices_scaled_98_symbol : Boolean;
          signal array_obj_ref_122_offset_calculated_99_symbol : Boolean;
          signal array_obj_ref_122_index_computed_0_100_symbol : Boolean;
          signal array_obj_ref_122_index_resized_0_101_symbol : Boolean;
          signal simple_obj_ref_121_complete_102_symbol : Boolean;
          signal array_obj_ref_122_index_resize_0_103_symbol : Boolean;
          signal array_obj_ref_122_index_scale_0_108_symbol : Boolean;
          signal array_obj_ref_122_add_indices_113_symbol : Boolean;
          signal array_obj_ref_122_base_address_resized_118_symbol : Boolean;
          signal array_obj_ref_122_base_addr_resize_119_symbol : Boolean;
          signal array_obj_ref_122_base_plus_offset_trigger_124_symbol : Boolean;
          signal array_obj_ref_122_base_plus_offset_125_symbol : Boolean;
          signal array_obj_ref_122_complete_132_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_123_89_start <= Xentry_17_symbol; -- control passed to block
          Xentry_90_symbol  <= assign_stmt_123_89_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/$entry
          assign_stmt_123_active_x_x92_symbol <= array_obj_ref_122_complete_132_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/assign_stmt_123_active_
          assign_stmt_123_completed_x_x93_symbol <= assign_stmt_123_active_x_x92_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/assign_stmt_123_completed_
          array_obj_ref_122_trigger_x_x94_symbol <= Xentry_90_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_trigger_
          array_obj_ref_122_active_x_x95_block : Block -- non-trivial join transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_active_ 
            signal array_obj_ref_122_active_x_x95_predecessors: BooleanArray(1 downto 0);
            -- 
          begin -- 
            array_obj_ref_122_active_x_x95_predecessors(0) <= array_obj_ref_122_trigger_x_x94_symbol;
            array_obj_ref_122_active_x_x95_predecessors(1) <= array_obj_ref_122_root_address_calculated_97_symbol;
            array_obj_ref_122_active_x_x95_join: join -- 
              port map( -- 
                preds => array_obj_ref_122_active_x_x95_predecessors,
                symbol_out => array_obj_ref_122_active_x_x95_symbol,
                clk => clk,
                reset => reset); -- 
            -- 
          end Block; -- non-trivial join transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_active_
          array_obj_ref_122_base_address_calculated_96_symbol <= Xentry_90_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_address_calculated
          array_obj_ref_122_root_address_calculated_97_symbol <= array_obj_ref_122_base_plus_offset_125_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_root_address_calculated
          array_obj_ref_122_indices_scaled_98_symbol <= array_obj_ref_122_index_scale_0_108_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_indices_scaled
          array_obj_ref_122_offset_calculated_99_symbol <= array_obj_ref_122_add_indices_113_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_offset_calculated
          array_obj_ref_122_index_computed_0_100_symbol <= simple_obj_ref_121_complete_102_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_index_computed_0
          array_obj_ref_122_index_resized_0_101_symbol <= array_obj_ref_122_index_resize_0_103_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_index_resized_0
          simple_obj_ref_121_complete_102_symbol <= Xentry_90_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/simple_obj_ref_121_complete
          array_obj_ref_122_index_resize_0_103: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_index_resize_0 
            signal array_obj_ref_122_index_resize_0_103_start: Boolean;
            signal Xentry_104_symbol: Boolean;
            signal Xexit_105_symbol: Boolean;
            signal index_resize_req_106_symbol : Boolean;
            signal index_resize_ack_107_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_122_index_resize_0_103_start <= array_obj_ref_122_index_computed_0_100_symbol; -- control passed to block
            Xentry_104_symbol  <= array_obj_ref_122_index_resize_0_103_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_index_resize_0/$entry
            index_resize_req_106_symbol <= Xentry_104_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_index_resize_0/index_resize_req
            array_obj_ref_122_index_0_resize_req_0 <= index_resize_req_106_symbol; -- link to DP
            index_resize_ack_107_symbol <= array_obj_ref_122_index_0_resize_ack_0; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_index_resize_0/index_resize_ack
            Xexit_105_symbol <= index_resize_ack_107_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_index_resize_0/$exit
            array_obj_ref_122_index_resize_0_103_symbol <= Xexit_105_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_index_resize_0
          array_obj_ref_122_index_scale_0_108: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_index_scale_0 
            signal array_obj_ref_122_index_scale_0_108_start: Boolean;
            signal Xentry_109_symbol: Boolean;
            signal Xexit_110_symbol: Boolean;
            signal scale_rename_req_111_symbol : Boolean;
            signal scale_rename_ack_112_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_122_index_scale_0_108_start <= array_obj_ref_122_index_resized_0_101_symbol; -- control passed to block
            Xentry_109_symbol  <= array_obj_ref_122_index_scale_0_108_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_index_scale_0/$entry
            scale_rename_req_111_symbol <= Xentry_109_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_index_scale_0/scale_rename_req
            array_obj_ref_122_index_0_rename_req_0 <= scale_rename_req_111_symbol; -- link to DP
            scale_rename_ack_112_symbol <= array_obj_ref_122_index_0_rename_ack_0; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_index_scale_0/scale_rename_ack
            Xexit_110_symbol <= scale_rename_ack_112_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_index_scale_0/$exit
            array_obj_ref_122_index_scale_0_108_symbol <= Xexit_110_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_index_scale_0
          array_obj_ref_122_add_indices_113: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_add_indices 
            signal array_obj_ref_122_add_indices_113_start: Boolean;
            signal Xentry_114_symbol: Boolean;
            signal Xexit_115_symbol: Boolean;
            signal final_index_req_116_symbol : Boolean;
            signal final_index_ack_117_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_122_add_indices_113_start <= array_obj_ref_122_indices_scaled_98_symbol; -- control passed to block
            Xentry_114_symbol  <= array_obj_ref_122_add_indices_113_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_add_indices/$entry
            final_index_req_116_symbol <= Xentry_114_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_add_indices/final_index_req
            array_obj_ref_122_offset_inst_req_0 <= final_index_req_116_symbol; -- link to DP
            final_index_ack_117_symbol <= array_obj_ref_122_offset_inst_ack_0; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_add_indices/final_index_ack
            Xexit_115_symbol <= final_index_ack_117_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_add_indices/$exit
            array_obj_ref_122_add_indices_113_symbol <= Xexit_115_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_add_indices
          array_obj_ref_122_base_address_resized_118_symbol <= array_obj_ref_122_base_addr_resize_119_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_address_resized
          array_obj_ref_122_base_addr_resize_119: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_addr_resize 
            signal array_obj_ref_122_base_addr_resize_119_start: Boolean;
            signal Xentry_120_symbol: Boolean;
            signal Xexit_121_symbol: Boolean;
            signal base_resize_req_122_symbol : Boolean;
            signal base_resize_ack_123_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_122_base_addr_resize_119_start <= array_obj_ref_122_base_address_calculated_96_symbol; -- control passed to block
            Xentry_120_symbol  <= array_obj_ref_122_base_addr_resize_119_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_addr_resize/$entry
            base_resize_req_122_symbol <= Xentry_120_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_addr_resize/base_resize_req
            array_obj_ref_122_base_resize_req_0 <= base_resize_req_122_symbol; -- link to DP
            base_resize_ack_123_symbol <= array_obj_ref_122_base_resize_ack_0; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_addr_resize/base_resize_ack
            Xexit_121_symbol <= base_resize_ack_123_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_addr_resize/$exit
            array_obj_ref_122_base_addr_resize_119_symbol <= Xexit_121_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_addr_resize
          array_obj_ref_122_base_plus_offset_trigger_124_block : Block -- non-trivial join transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_plus_offset_trigger 
            signal array_obj_ref_122_base_plus_offset_trigger_124_predecessors: BooleanArray(1 downto 0);
            -- 
          begin -- 
            array_obj_ref_122_base_plus_offset_trigger_124_predecessors(0) <= array_obj_ref_122_base_address_resized_118_symbol;
            array_obj_ref_122_base_plus_offset_trigger_124_predecessors(1) <= array_obj_ref_122_offset_calculated_99_symbol;
            array_obj_ref_122_base_plus_offset_trigger_124_join: join -- 
              port map( -- 
                preds => array_obj_ref_122_base_plus_offset_trigger_124_predecessors,
                symbol_out => array_obj_ref_122_base_plus_offset_trigger_124_symbol,
                clk => clk,
                reset => reset); -- 
            -- 
          end Block; -- non-trivial join transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_plus_offset_trigger
          array_obj_ref_122_base_plus_offset_125: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_plus_offset 
            signal array_obj_ref_122_base_plus_offset_125_start: Boolean;
            signal Xentry_126_symbol: Boolean;
            signal Xexit_127_symbol: Boolean;
            signal plus_base_rr_128_symbol : Boolean;
            signal plus_base_ra_129_symbol : Boolean;
            signal plus_base_cr_130_symbol : Boolean;
            signal plus_base_ca_131_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_122_base_plus_offset_125_start <= array_obj_ref_122_base_plus_offset_trigger_124_symbol; -- control passed to block
            Xentry_126_symbol  <= array_obj_ref_122_base_plus_offset_125_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_plus_offset/$entry
            plus_base_rr_128_symbol <= Xentry_126_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_plus_offset/plus_base_rr
            array_obj_ref_122_root_address_inst_req_0 <= plus_base_rr_128_symbol; -- link to DP
            plus_base_ra_129_symbol <= array_obj_ref_122_root_address_inst_ack_0; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_plus_offset/plus_base_ra
            plus_base_cr_130_symbol <= plus_base_ra_129_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_plus_offset/plus_base_cr
            array_obj_ref_122_root_address_inst_req_1 <= plus_base_cr_130_symbol; -- link to DP
            plus_base_ca_131_symbol <= array_obj_ref_122_root_address_inst_ack_1; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_plus_offset/plus_base_ca
            Xexit_127_symbol <= plus_base_ca_131_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_plus_offset/$exit
            array_obj_ref_122_base_plus_offset_125_symbol <= Xexit_127_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_base_plus_offset
          array_obj_ref_122_complete_132: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_complete 
            signal array_obj_ref_122_complete_132_start: Boolean;
            signal Xentry_133_symbol: Boolean;
            signal Xexit_134_symbol: Boolean;
            signal final_reg_req_135_symbol : Boolean;
            signal final_reg_ack_136_symbol : Boolean;
            -- 
          begin -- 
            array_obj_ref_122_complete_132_start <= array_obj_ref_122_active_x_x95_symbol; -- control passed to block
            Xentry_133_symbol  <= array_obj_ref_122_complete_132_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_complete/$entry
            final_reg_req_135_symbol <= Xentry_133_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_complete/final_reg_req
            array_obj_ref_122_final_reg_req_0 <= final_reg_req_135_symbol; -- link to DP
            final_reg_ack_136_symbol <= array_obj_ref_122_final_reg_ack_0; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_complete/final_reg_ack
            Xexit_134_symbol <= final_reg_ack_136_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_complete/$exit
            array_obj_ref_122_complete_132_symbol <= Xexit_134_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/array_obj_ref_122_complete
          Xexit_91_symbol <= assign_stmt_123_completed_x_x93_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123/$exit
          assign_stmt_123_89_symbol <= Xexit_91_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_123
        assign_stmt_128_137: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128 
          signal assign_stmt_128_137_start: Boolean;
          signal Xentry_138_symbol: Boolean;
          signal Xexit_139_symbol: Boolean;
          signal assign_stmt_128_active_x_x140_symbol : Boolean;
          signal assign_stmt_128_completed_x_x141_symbol : Boolean;
          signal binary_127_active_x_x142_symbol : Boolean;
          signal binary_127_trigger_x_x143_symbol : Boolean;
          signal simple_obj_ref_125_complete_144_symbol : Boolean;
          signal binary_127_complete_145_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_128_137_start <= Xentry_17_symbol; -- control passed to block
          Xentry_138_symbol  <= assign_stmt_128_137_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128/$entry
          assign_stmt_128_active_x_x140_symbol <= binary_127_complete_145_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128/assign_stmt_128_active_
          assign_stmt_128_completed_x_x141_symbol <= assign_stmt_128_active_x_x140_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128/assign_stmt_128_completed_
          binary_127_active_x_x142_block : Block -- non-trivial join transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128/binary_127_active_ 
            signal binary_127_active_x_x142_predecessors: BooleanArray(1 downto 0);
            -- 
          begin -- 
            binary_127_active_x_x142_predecessors(0) <= binary_127_trigger_x_x143_symbol;
            binary_127_active_x_x142_predecessors(1) <= simple_obj_ref_125_complete_144_symbol;
            binary_127_active_x_x142_join: join -- 
              port map( -- 
                preds => binary_127_active_x_x142_predecessors,
                symbol_out => binary_127_active_x_x142_symbol,
                clk => clk,
                reset => reset); -- 
            -- 
          end Block; -- non-trivial join transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128/binary_127_active_
          binary_127_trigger_x_x143_symbol <= Xentry_138_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128/binary_127_trigger_
          simple_obj_ref_125_complete_144_symbol <= Xentry_138_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128/simple_obj_ref_125_complete
          binary_127_complete_145: Block -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128/binary_127_complete 
            signal binary_127_complete_145_start: Boolean;
            signal Xentry_146_symbol: Boolean;
            signal Xexit_147_symbol: Boolean;
            signal rr_148_symbol : Boolean;
            signal ra_149_symbol : Boolean;
            signal cr_150_symbol : Boolean;
            signal ca_151_symbol : Boolean;
            -- 
          begin -- 
            binary_127_complete_145_start <= binary_127_active_x_x142_symbol; -- control passed to block
            Xentry_146_symbol  <= binary_127_complete_145_start; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128/binary_127_complete/$entry
            rr_148_symbol <= Xentry_146_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128/binary_127_complete/rr
            binary_127_inst_req_0 <= rr_148_symbol; -- link to DP
            ra_149_symbol <= binary_127_inst_ack_0; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128/binary_127_complete/ra
            cr_150_symbol <= ra_149_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128/binary_127_complete/cr
            binary_127_inst_req_1 <= cr_150_symbol; -- link to DP
            ca_151_symbol <= binary_127_inst_ack_1; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128/binary_127_complete/ca
            Xexit_147_symbol <= ca_151_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128/binary_127_complete/$exit
            binary_127_complete_145_symbol <= Xexit_147_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128/binary_127_complete
          Xexit_139_symbol <= assign_stmt_128_completed_x_x141_symbol; -- transition branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128/$exit
          assign_stmt_128_137_symbol <= Xexit_139_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/parallel_block_stmt_109/assign_stmt_128
        Xexit_18_block : Block -- non-trivial join transition branch_block_stmt_101/parallel_block_stmt_109/$exit 
          signal Xexit_18_predecessors: BooleanArray(4 downto 0);
          -- 
        begin -- 
          Xexit_18_predecessors(0) <= assign_stmt_112_19_symbol;
          Xexit_18_predecessors(1) <= assign_stmt_115_30_symbol;
          Xexit_18_predecessors(2) <= assign_stmt_119_41_symbol;
          Xexit_18_predecessors(3) <= assign_stmt_123_89_symbol;
          Xexit_18_predecessors(4) <= assign_stmt_128_137_symbol;
          Xexit_18_join: join -- 
            port map( -- 
              preds => Xexit_18_predecessors,
              symbol_out => Xexit_18_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_101/parallel_block_stmt_109/$exit
        parallel_block_stmt_109_16_symbol <= Xexit_18_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_101/parallel_block_stmt_109
      assign_stmt_133_to_assign_stmt_140_152: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140 
        signal assign_stmt_133_to_assign_stmt_140_152_start: Boolean;
        signal Xentry_153_symbol: Boolean;
        signal Xexit_154_symbol: Boolean;
        signal assign_stmt_133_active_x_x155_symbol : Boolean;
        signal assign_stmt_133_completed_x_x156_symbol : Boolean;
        signal simple_obj_ref_132_complete_157_symbol : Boolean;
        signal ptr_deref_131_trigger_x_x158_symbol : Boolean;
        signal ptr_deref_131_active_x_x159_symbol : Boolean;
        signal ptr_deref_131_base_address_calculated_160_symbol : Boolean;
        signal simple_obj_ref_130_complete_161_symbol : Boolean;
        signal ptr_deref_131_root_address_calculated_162_symbol : Boolean;
        signal ptr_deref_131_word_address_calculated_163_symbol : Boolean;
        signal ptr_deref_131_base_address_resized_164_symbol : Boolean;
        signal ptr_deref_131_base_addr_resize_165_symbol : Boolean;
        signal ptr_deref_131_base_plus_offset_170_symbol : Boolean;
        signal ptr_deref_131_word_addrgen_175_symbol : Boolean;
        signal ptr_deref_131_request_180_symbol : Boolean;
        signal ptr_deref_131_complete_193_symbol : Boolean;
        signal assign_stmt_137_active_x_x204_symbol : Boolean;
        signal assign_stmt_137_completed_x_x205_symbol : Boolean;
        signal simple_obj_ref_136_complete_206_symbol : Boolean;
        signal ptr_deref_135_trigger_x_x207_symbol : Boolean;
        signal ptr_deref_135_active_x_x208_symbol : Boolean;
        signal ptr_deref_135_base_address_calculated_209_symbol : Boolean;
        signal simple_obj_ref_134_complete_210_symbol : Boolean;
        signal ptr_deref_135_root_address_calculated_211_symbol : Boolean;
        signal ptr_deref_135_word_address_calculated_212_symbol : Boolean;
        signal ptr_deref_135_base_address_resized_213_symbol : Boolean;
        signal ptr_deref_135_base_addr_resize_214_symbol : Boolean;
        signal ptr_deref_135_base_plus_offset_219_symbol : Boolean;
        signal ptr_deref_135_word_addrgen_224_symbol : Boolean;
        signal ptr_deref_135_request_229_symbol : Boolean;
        signal ptr_deref_135_complete_242_symbol : Boolean;
        signal assign_stmt_140_active_x_x253_symbol : Boolean;
        signal assign_stmt_140_completed_x_x254_symbol : Boolean;
        signal simple_obj_ref_139_complete_255_symbol : Boolean;
        signal assign_stmt_140_register_256_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_133_to_assign_stmt_140_152_start <= assign_stmt_133_to_assign_stmt_140_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_153_symbol  <= assign_stmt_133_to_assign_stmt_140_152_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/$entry
        assign_stmt_133_active_x_x155_symbol <= simple_obj_ref_132_complete_157_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/assign_stmt_133_active_
        assign_stmt_133_completed_x_x156_symbol <= ptr_deref_131_complete_193_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/assign_stmt_133_completed_
        simple_obj_ref_132_complete_157_symbol <= Xentry_153_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/simple_obj_ref_132_complete
        ptr_deref_131_trigger_x_x158_block : Block -- non-trivial join transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_trigger_ 
          signal ptr_deref_131_trigger_x_x158_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          ptr_deref_131_trigger_x_x158_predecessors(0) <= ptr_deref_131_word_address_calculated_163_symbol;
          ptr_deref_131_trigger_x_x158_predecessors(1) <= ptr_deref_131_base_address_calculated_160_symbol;
          ptr_deref_131_trigger_x_x158_predecessors(2) <= assign_stmt_133_active_x_x155_symbol;
          ptr_deref_131_trigger_x_x158_join: join -- 
            port map( -- 
              preds => ptr_deref_131_trigger_x_x158_predecessors,
              symbol_out => ptr_deref_131_trigger_x_x158_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_trigger_
        ptr_deref_131_active_x_x159_symbol <= ptr_deref_131_request_180_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_active_
        ptr_deref_131_base_address_calculated_160_symbol <= simple_obj_ref_130_complete_161_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_base_address_calculated
        simple_obj_ref_130_complete_161_symbol <= Xentry_153_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/simple_obj_ref_130_complete
        ptr_deref_131_root_address_calculated_162_symbol <= ptr_deref_131_base_plus_offset_170_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_root_address_calculated
        ptr_deref_131_word_address_calculated_163_symbol <= ptr_deref_131_word_addrgen_175_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_word_address_calculated
        ptr_deref_131_base_address_resized_164_symbol <= ptr_deref_131_base_addr_resize_165_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_base_address_resized
        ptr_deref_131_base_addr_resize_165: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_base_addr_resize 
          signal ptr_deref_131_base_addr_resize_165_start: Boolean;
          signal Xentry_166_symbol: Boolean;
          signal Xexit_167_symbol: Boolean;
          signal base_resize_req_168_symbol : Boolean;
          signal base_resize_ack_169_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_131_base_addr_resize_165_start <= ptr_deref_131_base_address_calculated_160_symbol; -- control passed to block
          Xentry_166_symbol  <= ptr_deref_131_base_addr_resize_165_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_base_addr_resize/$entry
          base_resize_req_168_symbol <= Xentry_166_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_base_addr_resize/base_resize_req
          ptr_deref_131_base_resize_req_0 <= base_resize_req_168_symbol; -- link to DP
          base_resize_ack_169_symbol <= ptr_deref_131_base_resize_ack_0; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_base_addr_resize/base_resize_ack
          Xexit_167_symbol <= base_resize_ack_169_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_base_addr_resize/$exit
          ptr_deref_131_base_addr_resize_165_symbol <= Xexit_167_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_base_addr_resize
        ptr_deref_131_base_plus_offset_170: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_base_plus_offset 
          signal ptr_deref_131_base_plus_offset_170_start: Boolean;
          signal Xentry_171_symbol: Boolean;
          signal Xexit_172_symbol: Boolean;
          signal sum_rename_req_173_symbol : Boolean;
          signal sum_rename_ack_174_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_131_base_plus_offset_170_start <= ptr_deref_131_base_address_resized_164_symbol; -- control passed to block
          Xentry_171_symbol  <= ptr_deref_131_base_plus_offset_170_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_base_plus_offset/$entry
          sum_rename_req_173_symbol <= Xentry_171_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_base_plus_offset/sum_rename_req
          ptr_deref_131_root_address_inst_req_0 <= sum_rename_req_173_symbol; -- link to DP
          sum_rename_ack_174_symbol <= ptr_deref_131_root_address_inst_ack_0; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_base_plus_offset/sum_rename_ack
          Xexit_172_symbol <= sum_rename_ack_174_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_base_plus_offset/$exit
          ptr_deref_131_base_plus_offset_170_symbol <= Xexit_172_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_base_plus_offset
        ptr_deref_131_word_addrgen_175: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_word_addrgen 
          signal ptr_deref_131_word_addrgen_175_start: Boolean;
          signal Xentry_176_symbol: Boolean;
          signal Xexit_177_symbol: Boolean;
          signal root_rename_req_178_symbol : Boolean;
          signal root_rename_ack_179_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_131_word_addrgen_175_start <= ptr_deref_131_root_address_calculated_162_symbol; -- control passed to block
          Xentry_176_symbol  <= ptr_deref_131_word_addrgen_175_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_word_addrgen/$entry
          root_rename_req_178_symbol <= Xentry_176_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_word_addrgen/root_rename_req
          ptr_deref_131_addr_0_req_0 <= root_rename_req_178_symbol; -- link to DP
          root_rename_ack_179_symbol <= ptr_deref_131_addr_0_ack_0; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_word_addrgen/root_rename_ack
          Xexit_177_symbol <= root_rename_ack_179_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_word_addrgen/$exit
          ptr_deref_131_word_addrgen_175_symbol <= Xexit_177_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_word_addrgen
        ptr_deref_131_request_180: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_request 
          signal ptr_deref_131_request_180_start: Boolean;
          signal Xentry_181_symbol: Boolean;
          signal Xexit_182_symbol: Boolean;
          signal split_req_183_symbol : Boolean;
          signal split_ack_184_symbol : Boolean;
          signal word_access_185_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_131_request_180_start <= ptr_deref_131_trigger_x_x158_symbol; -- control passed to block
          Xentry_181_symbol  <= ptr_deref_131_request_180_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_request/$entry
          split_req_183_symbol <= Xentry_181_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_request/split_req
          ptr_deref_131_gather_scatter_req_0 <= split_req_183_symbol; -- link to DP
          split_ack_184_symbol <= ptr_deref_131_gather_scatter_ack_0; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_request/split_ack
          word_access_185: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_request/word_access 
            signal word_access_185_start: Boolean;
            signal Xentry_186_symbol: Boolean;
            signal Xexit_187_symbol: Boolean;
            signal word_access_0_188_symbol : Boolean;
            -- 
          begin -- 
            word_access_185_start <= split_ack_184_symbol; -- control passed to block
            Xentry_186_symbol  <= word_access_185_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_request/word_access/$entry
            word_access_0_188: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_request/word_access/word_access_0 
              signal word_access_0_188_start: Boolean;
              signal Xentry_189_symbol: Boolean;
              signal Xexit_190_symbol: Boolean;
              signal rr_191_symbol : Boolean;
              signal ra_192_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_188_start <= Xentry_186_symbol; -- control passed to block
              Xentry_189_symbol  <= word_access_0_188_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_request/word_access/word_access_0/$entry
              rr_191_symbol <= Xentry_189_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_request/word_access/word_access_0/rr
              ptr_deref_131_store_0_req_0 <= rr_191_symbol; -- link to DP
              ra_192_symbol <= ptr_deref_131_store_0_ack_0; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_request/word_access/word_access_0/ra
              Xexit_190_symbol <= ra_192_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_request/word_access/word_access_0/$exit
              word_access_0_188_symbol <= Xexit_190_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_request/word_access/word_access_0
            Xexit_187_symbol <= word_access_0_188_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_request/word_access/$exit
            word_access_185_symbol <= Xexit_187_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_request/word_access
          Xexit_182_symbol <= word_access_185_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_request/$exit
          ptr_deref_131_request_180_symbol <= Xexit_182_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_request
        ptr_deref_131_complete_193: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_complete 
          signal ptr_deref_131_complete_193_start: Boolean;
          signal Xentry_194_symbol: Boolean;
          signal Xexit_195_symbol: Boolean;
          signal word_access_196_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_131_complete_193_start <= ptr_deref_131_active_x_x159_symbol; -- control passed to block
          Xentry_194_symbol  <= ptr_deref_131_complete_193_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_complete/$entry
          word_access_196: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_complete/word_access 
            signal word_access_196_start: Boolean;
            signal Xentry_197_symbol: Boolean;
            signal Xexit_198_symbol: Boolean;
            signal word_access_0_199_symbol : Boolean;
            -- 
          begin -- 
            word_access_196_start <= Xentry_194_symbol; -- control passed to block
            Xentry_197_symbol  <= word_access_196_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_complete/word_access/$entry
            word_access_0_199: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_complete/word_access/word_access_0 
              signal word_access_0_199_start: Boolean;
              signal Xentry_200_symbol: Boolean;
              signal Xexit_201_symbol: Boolean;
              signal cr_202_symbol : Boolean;
              signal ca_203_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_199_start <= Xentry_197_symbol; -- control passed to block
              Xentry_200_symbol  <= word_access_0_199_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_complete/word_access/word_access_0/$entry
              cr_202_symbol <= Xentry_200_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_complete/word_access/word_access_0/cr
              ptr_deref_131_store_0_req_1 <= cr_202_symbol; -- link to DP
              ca_203_symbol <= ptr_deref_131_store_0_ack_1; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_complete/word_access/word_access_0/ca
              Xexit_201_symbol <= ca_203_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_complete/word_access/word_access_0/$exit
              word_access_0_199_symbol <= Xexit_201_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_complete/word_access/word_access_0
            Xexit_198_symbol <= word_access_0_199_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_complete/word_access/$exit
            word_access_196_symbol <= Xexit_198_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_complete/word_access
          Xexit_195_symbol <= word_access_196_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_complete/$exit
          ptr_deref_131_complete_193_symbol <= Xexit_195_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_131_complete
        assign_stmt_137_active_x_x204_symbol <= simple_obj_ref_136_complete_206_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/assign_stmt_137_active_
        assign_stmt_137_completed_x_x205_symbol <= ptr_deref_135_complete_242_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/assign_stmt_137_completed_
        simple_obj_ref_136_complete_206_symbol <= Xentry_153_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/simple_obj_ref_136_complete
        ptr_deref_135_trigger_x_x207_block : Block -- non-trivial join transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_trigger_ 
          signal ptr_deref_135_trigger_x_x207_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          ptr_deref_135_trigger_x_x207_predecessors(0) <= ptr_deref_135_word_address_calculated_212_symbol;
          ptr_deref_135_trigger_x_x207_predecessors(1) <= ptr_deref_135_base_address_calculated_209_symbol;
          ptr_deref_135_trigger_x_x207_predecessors(2) <= assign_stmt_137_active_x_x204_symbol;
          ptr_deref_135_trigger_x_x207_join: join -- 
            port map( -- 
              preds => ptr_deref_135_trigger_x_x207_predecessors,
              symbol_out => ptr_deref_135_trigger_x_x207_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_trigger_
        ptr_deref_135_active_x_x208_symbol <= ptr_deref_135_request_229_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_active_
        ptr_deref_135_base_address_calculated_209_symbol <= simple_obj_ref_134_complete_210_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_base_address_calculated
        simple_obj_ref_134_complete_210_symbol <= Xentry_153_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/simple_obj_ref_134_complete
        ptr_deref_135_root_address_calculated_211_symbol <= ptr_deref_135_base_plus_offset_219_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_root_address_calculated
        ptr_deref_135_word_address_calculated_212_symbol <= ptr_deref_135_word_addrgen_224_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_word_address_calculated
        ptr_deref_135_base_address_resized_213_symbol <= ptr_deref_135_base_addr_resize_214_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_base_address_resized
        ptr_deref_135_base_addr_resize_214: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_base_addr_resize 
          signal ptr_deref_135_base_addr_resize_214_start: Boolean;
          signal Xentry_215_symbol: Boolean;
          signal Xexit_216_symbol: Boolean;
          signal base_resize_req_217_symbol : Boolean;
          signal base_resize_ack_218_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_135_base_addr_resize_214_start <= ptr_deref_135_base_address_calculated_209_symbol; -- control passed to block
          Xentry_215_symbol  <= ptr_deref_135_base_addr_resize_214_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_base_addr_resize/$entry
          base_resize_req_217_symbol <= Xentry_215_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_base_addr_resize/base_resize_req
          ptr_deref_135_base_resize_req_0 <= base_resize_req_217_symbol; -- link to DP
          base_resize_ack_218_symbol <= ptr_deref_135_base_resize_ack_0; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_base_addr_resize/base_resize_ack
          Xexit_216_symbol <= base_resize_ack_218_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_base_addr_resize/$exit
          ptr_deref_135_base_addr_resize_214_symbol <= Xexit_216_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_base_addr_resize
        ptr_deref_135_base_plus_offset_219: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_base_plus_offset 
          signal ptr_deref_135_base_plus_offset_219_start: Boolean;
          signal Xentry_220_symbol: Boolean;
          signal Xexit_221_symbol: Boolean;
          signal sum_rename_req_222_symbol : Boolean;
          signal sum_rename_ack_223_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_135_base_plus_offset_219_start <= ptr_deref_135_base_address_resized_213_symbol; -- control passed to block
          Xentry_220_symbol  <= ptr_deref_135_base_plus_offset_219_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_base_plus_offset/$entry
          sum_rename_req_222_symbol <= Xentry_220_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_base_plus_offset/sum_rename_req
          ptr_deref_135_root_address_inst_req_0 <= sum_rename_req_222_symbol; -- link to DP
          sum_rename_ack_223_symbol <= ptr_deref_135_root_address_inst_ack_0; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_base_plus_offset/sum_rename_ack
          Xexit_221_symbol <= sum_rename_ack_223_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_base_plus_offset/$exit
          ptr_deref_135_base_plus_offset_219_symbol <= Xexit_221_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_base_plus_offset
        ptr_deref_135_word_addrgen_224: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_word_addrgen 
          signal ptr_deref_135_word_addrgen_224_start: Boolean;
          signal Xentry_225_symbol: Boolean;
          signal Xexit_226_symbol: Boolean;
          signal root_rename_req_227_symbol : Boolean;
          signal root_rename_ack_228_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_135_word_addrgen_224_start <= ptr_deref_135_root_address_calculated_211_symbol; -- control passed to block
          Xentry_225_symbol  <= ptr_deref_135_word_addrgen_224_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_word_addrgen/$entry
          root_rename_req_227_symbol <= Xentry_225_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_word_addrgen/root_rename_req
          ptr_deref_135_addr_0_req_0 <= root_rename_req_227_symbol; -- link to DP
          root_rename_ack_228_symbol <= ptr_deref_135_addr_0_ack_0; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_word_addrgen/root_rename_ack
          Xexit_226_symbol <= root_rename_ack_228_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_word_addrgen/$exit
          ptr_deref_135_word_addrgen_224_symbol <= Xexit_226_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_word_addrgen
        ptr_deref_135_request_229: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_request 
          signal ptr_deref_135_request_229_start: Boolean;
          signal Xentry_230_symbol: Boolean;
          signal Xexit_231_symbol: Boolean;
          signal split_req_232_symbol : Boolean;
          signal split_ack_233_symbol : Boolean;
          signal word_access_234_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_135_request_229_start <= ptr_deref_135_trigger_x_x207_symbol; -- control passed to block
          Xentry_230_symbol  <= ptr_deref_135_request_229_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_request/$entry
          split_req_232_symbol <= Xentry_230_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_request/split_req
          ptr_deref_135_gather_scatter_req_0 <= split_req_232_symbol; -- link to DP
          split_ack_233_symbol <= ptr_deref_135_gather_scatter_ack_0; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_request/split_ack
          word_access_234: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_request/word_access 
            signal word_access_234_start: Boolean;
            signal Xentry_235_symbol: Boolean;
            signal Xexit_236_symbol: Boolean;
            signal word_access_0_237_symbol : Boolean;
            -- 
          begin -- 
            word_access_234_start <= split_ack_233_symbol; -- control passed to block
            Xentry_235_symbol  <= word_access_234_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_request/word_access/$entry
            word_access_0_237: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_request/word_access/word_access_0 
              signal word_access_0_237_start: Boolean;
              signal Xentry_238_symbol: Boolean;
              signal Xexit_239_symbol: Boolean;
              signal rr_240_symbol : Boolean;
              signal ra_241_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_237_start <= Xentry_235_symbol; -- control passed to block
              Xentry_238_symbol  <= word_access_0_237_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_request/word_access/word_access_0/$entry
              rr_240_symbol <= Xentry_238_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_request/word_access/word_access_0/rr
              ptr_deref_135_store_0_req_0 <= rr_240_symbol; -- link to DP
              ra_241_symbol <= ptr_deref_135_store_0_ack_0; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_request/word_access/word_access_0/ra
              Xexit_239_symbol <= ra_241_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_request/word_access/word_access_0/$exit
              word_access_0_237_symbol <= Xexit_239_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_request/word_access/word_access_0
            Xexit_236_symbol <= word_access_0_237_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_request/word_access/$exit
            word_access_234_symbol <= Xexit_236_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_request/word_access
          Xexit_231_symbol <= word_access_234_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_request/$exit
          ptr_deref_135_request_229_symbol <= Xexit_231_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_request
        ptr_deref_135_complete_242: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_complete 
          signal ptr_deref_135_complete_242_start: Boolean;
          signal Xentry_243_symbol: Boolean;
          signal Xexit_244_symbol: Boolean;
          signal word_access_245_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_135_complete_242_start <= ptr_deref_135_active_x_x208_symbol; -- control passed to block
          Xentry_243_symbol  <= ptr_deref_135_complete_242_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_complete/$entry
          word_access_245: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_complete/word_access 
            signal word_access_245_start: Boolean;
            signal Xentry_246_symbol: Boolean;
            signal Xexit_247_symbol: Boolean;
            signal word_access_0_248_symbol : Boolean;
            -- 
          begin -- 
            word_access_245_start <= Xentry_243_symbol; -- control passed to block
            Xentry_246_symbol  <= word_access_245_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_complete/word_access/$entry
            word_access_0_248: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_complete/word_access/word_access_0 
              signal word_access_0_248_start: Boolean;
              signal Xentry_249_symbol: Boolean;
              signal Xexit_250_symbol: Boolean;
              signal cr_251_symbol : Boolean;
              signal ca_252_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_248_start <= Xentry_246_symbol; -- control passed to block
              Xentry_249_symbol  <= word_access_0_248_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_complete/word_access/word_access_0/$entry
              cr_251_symbol <= Xentry_249_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_complete/word_access/word_access_0/cr
              ptr_deref_135_store_0_req_1 <= cr_251_symbol; -- link to DP
              ca_252_symbol <= ptr_deref_135_store_0_ack_1; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_complete/word_access/word_access_0/ca
              Xexit_250_symbol <= ca_252_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_complete/word_access/word_access_0/$exit
              word_access_0_248_symbol <= Xexit_250_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_complete/word_access/word_access_0
            Xexit_247_symbol <= word_access_0_248_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_complete/word_access/$exit
            word_access_245_symbol <= Xexit_247_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_complete/word_access
          Xexit_244_symbol <= word_access_245_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_complete/$exit
          ptr_deref_135_complete_242_symbol <= Xexit_244_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/ptr_deref_135_complete
        assign_stmt_140_active_x_x253_symbol <= simple_obj_ref_139_complete_255_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/assign_stmt_140_active_
        assign_stmt_140_completed_x_x254_block : Block -- non-trivial join transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/assign_stmt_140_completed_ 
          signal assign_stmt_140_completed_x_x254_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          assign_stmt_140_completed_x_x254_predecessors(0) <= assign_stmt_140_active_x_x253_symbol;
          assign_stmt_140_completed_x_x254_predecessors(1) <= assign_stmt_140_register_256_symbol;
          assign_stmt_140_completed_x_x254_join: join -- 
            port map( -- 
              preds => assign_stmt_140_completed_x_x254_predecessors,
              symbol_out => assign_stmt_140_completed_x_x254_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/assign_stmt_140_completed_
        simple_obj_ref_139_complete_255_symbol <= Xentry_153_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/simple_obj_ref_139_complete
        assign_stmt_140_register_256: Block -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/assign_stmt_140_register 
          signal assign_stmt_140_register_256_start: Boolean;
          signal Xentry_257_symbol: Boolean;
          signal Xexit_258_symbol: Boolean;
          signal req_259_symbol : Boolean;
          signal ack_260_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_140_register_256_start <= assign_stmt_140_active_x_x253_symbol; -- control passed to block
          Xentry_257_symbol  <= assign_stmt_140_register_256_start; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/assign_stmt_140_register/$entry
          req_259_symbol <= Xentry_257_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/assign_stmt_140_register/req
          simple_obj_ref_138_inst_req_0 <= req_259_symbol; -- link to DP
          ack_260_symbol <= simple_obj_ref_138_inst_ack_0; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/assign_stmt_140_register/ack
          Xexit_258_symbol <= ack_260_symbol; -- transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/assign_stmt_140_register/$exit
          assign_stmt_140_register_256_symbol <= Xexit_258_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/assign_stmt_140_register
        Xexit_154_block : Block -- non-trivial join transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/$exit 
          signal Xexit_154_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          Xexit_154_predecessors(0) <= assign_stmt_133_completed_x_x156_symbol;
          Xexit_154_predecessors(1) <= assign_stmt_137_completed_x_x205_symbol;
          Xexit_154_predecessors(2) <= assign_stmt_140_completed_x_x254_symbol;
          Xexit_154_join: join -- 
            port map( -- 
              preds => Xexit_154_predecessors,
              symbol_out => Xexit_154_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140/$exit
        assign_stmt_133_to_assign_stmt_140_152_symbol <= Xexit_154_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_101/assign_stmt_133_to_assign_stmt_140
      switch_stmt_141_dead_link_261: Block -- branch_block_stmt_101/switch_stmt_141_dead_link 
        signal switch_stmt_141_dead_link_261_start: Boolean;
        signal Xentry_262_symbol: Boolean;
        signal Xexit_263_symbol: Boolean;
        signal dead_transition_264_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_141_dead_link_261_start <= switch_stmt_141_x_xentry_x_xx_x14_symbol; -- control passed to block
        Xentry_262_symbol  <= switch_stmt_141_dead_link_261_start; -- transition branch_block_stmt_101/switch_stmt_141_dead_link/$entry
        dead_transition_264_symbol <= false;
        Xexit_263_symbol <= dead_transition_264_symbol; -- transition branch_block_stmt_101/switch_stmt_141_dead_link/$exit
        switch_stmt_141_dead_link_261_symbol <= Xexit_263_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_101/switch_stmt_141_dead_link
      switch_stmt_141_x_xcondition_check_place_x_xx_x265_symbol  <=  switch_stmt_141_x_xentry_x_xx_x14_symbol; -- place branch_block_stmt_101/switch_stmt_141__condition_check_place__ (optimized away) 
      switch_stmt_141_x_xcondition_check_x_xx_x266: Block -- branch_block_stmt_101/switch_stmt_141__condition_check__ 
        signal switch_stmt_141_x_xcondition_check_x_xx_x266_start: Boolean;
        signal Xentry_267_symbol: Boolean;
        signal Xexit_268_symbol: Boolean;
        signal condition_0_269_symbol : Boolean;
        signal condition_1_277_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_141_x_xcondition_check_x_xx_x266_start <= switch_stmt_141_x_xcondition_check_place_x_xx_x265_symbol; -- control passed to block
        Xentry_267_symbol  <= switch_stmt_141_x_xcondition_check_x_xx_x266_start; -- transition branch_block_stmt_101/switch_stmt_141__condition_check__/$entry
        condition_0_269: Block -- branch_block_stmt_101/switch_stmt_141__condition_check__/condition_0 
          signal condition_0_269_start: Boolean;
          signal Xentry_270_symbol: Boolean;
          signal Xexit_271_symbol: Boolean;
          signal rr_272_symbol : Boolean;
          signal ra_273_symbol : Boolean;
          signal cr_274_symbol : Boolean;
          signal ca_275_symbol : Boolean;
          signal cmp_276_symbol : Boolean;
          -- 
        begin -- 
          condition_0_269_start <= Xentry_267_symbol; -- control passed to block
          Xentry_270_symbol  <= condition_0_269_start; -- transition branch_block_stmt_101/switch_stmt_141__condition_check__/condition_0/$entry
          rr_272_symbol <= Xentry_270_symbol; -- transition branch_block_stmt_101/switch_stmt_141__condition_check__/condition_0/rr
          switch_stmt_141_select_expr_0_req_0 <= rr_272_symbol; -- link to DP
          ra_273_symbol <= switch_stmt_141_select_expr_0_ack_0; -- transition branch_block_stmt_101/switch_stmt_141__condition_check__/condition_0/ra
          cr_274_symbol <= ra_273_symbol; -- transition branch_block_stmt_101/switch_stmt_141__condition_check__/condition_0/cr
          switch_stmt_141_select_expr_0_req_1 <= cr_274_symbol; -- link to DP
          ca_275_symbol <= switch_stmt_141_select_expr_0_ack_1; -- transition branch_block_stmt_101/switch_stmt_141__condition_check__/condition_0/ca
          cmp_276_symbol <= ca_275_symbol; -- transition branch_block_stmt_101/switch_stmt_141__condition_check__/condition_0/cmp
          switch_stmt_141_branch_0_req_0 <= cmp_276_symbol; -- link to DP
          Xexit_271_symbol <= cmp_276_symbol; -- transition branch_block_stmt_101/switch_stmt_141__condition_check__/condition_0/$exit
          condition_0_269_symbol <= Xexit_271_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/switch_stmt_141__condition_check__/condition_0
        condition_1_277: Block -- branch_block_stmt_101/switch_stmt_141__condition_check__/condition_1 
          signal condition_1_277_start: Boolean;
          signal Xentry_278_symbol: Boolean;
          signal Xexit_279_symbol: Boolean;
          signal rr_280_symbol : Boolean;
          signal ra_281_symbol : Boolean;
          signal cr_282_symbol : Boolean;
          signal ca_283_symbol : Boolean;
          signal cmp_284_symbol : Boolean;
          -- 
        begin -- 
          condition_1_277_start <= Xentry_267_symbol; -- control passed to block
          Xentry_278_symbol  <= condition_1_277_start; -- transition branch_block_stmt_101/switch_stmt_141__condition_check__/condition_1/$entry
          rr_280_symbol <= Xentry_278_symbol; -- transition branch_block_stmt_101/switch_stmt_141__condition_check__/condition_1/rr
          switch_stmt_141_select_expr_1_req_0 <= rr_280_symbol; -- link to DP
          ra_281_symbol <= switch_stmt_141_select_expr_1_ack_0; -- transition branch_block_stmt_101/switch_stmt_141__condition_check__/condition_1/ra
          cr_282_symbol <= ra_281_symbol; -- transition branch_block_stmt_101/switch_stmt_141__condition_check__/condition_1/cr
          switch_stmt_141_select_expr_1_req_1 <= cr_282_symbol; -- link to DP
          ca_283_symbol <= switch_stmt_141_select_expr_1_ack_1; -- transition branch_block_stmt_101/switch_stmt_141__condition_check__/condition_1/ca
          cmp_284_symbol <= ca_283_symbol; -- transition branch_block_stmt_101/switch_stmt_141__condition_check__/condition_1/cmp
          switch_stmt_141_branch_1_req_0 <= cmp_284_symbol; -- link to DP
          Xexit_279_symbol <= cmp_284_symbol; -- transition branch_block_stmt_101/switch_stmt_141__condition_check__/condition_1/$exit
          condition_1_277_symbol <= Xexit_279_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/switch_stmt_141__condition_check__/condition_1
        Xexit_268_block : Block -- non-trivial join transition branch_block_stmt_101/switch_stmt_141__condition_check__/$exit 
          signal Xexit_268_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_268_predecessors(0) <= condition_0_269_symbol;
          Xexit_268_predecessors(1) <= condition_1_277_symbol;
          Xexit_268_join: join -- 
            port map( -- 
              preds => Xexit_268_predecessors,
              symbol_out => Xexit_268_symbol,
              clk => clk,
              reset => reset); -- 
          switch_stmt_141_branch_default_req_0 <= Xexit_268_symbol; -- link to DP
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_101/switch_stmt_141__condition_check__/$exit
        switch_stmt_141_x_xcondition_check_x_xx_x266_symbol <= Xexit_268_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_101/switch_stmt_141__condition_check__
      switch_stmt_141_x_xselect_x_xx_x285_symbol  <=  switch_stmt_141_x_xcondition_check_x_xx_x266_symbol; -- place branch_block_stmt_101/switch_stmt_141__select__ (optimized away) 
      switch_stmt_141_choice_0_286: Block -- branch_block_stmt_101/switch_stmt_141_choice_0 
        signal switch_stmt_141_choice_0_286_start: Boolean;
        signal Xentry_287_symbol: Boolean;
        signal Xexit_288_symbol: Boolean;
        signal ack1_289_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_141_choice_0_286_start <= switch_stmt_141_x_xselect_x_xx_x285_symbol; -- control passed to block
        Xentry_287_symbol  <= switch_stmt_141_choice_0_286_start; -- transition branch_block_stmt_101/switch_stmt_141_choice_0/$entry
        ack1_289_symbol <= switch_stmt_141_branch_0_ack_1; -- transition branch_block_stmt_101/switch_stmt_141_choice_0/ack1
        Xexit_288_symbol <= ack1_289_symbol; -- transition branch_block_stmt_101/switch_stmt_141_choice_0/$exit
        switch_stmt_141_choice_0_286_symbol <= Xexit_288_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_101/switch_stmt_141_choice_0
      loopback_290_symbol  <=  switch_stmt_141_choice_0_286_symbol or switch_stmt_141_choice_1_291_symbol; -- place branch_block_stmt_101/loopback (optimized away) 
      switch_stmt_141_choice_1_291: Block -- branch_block_stmt_101/switch_stmt_141_choice_1 
        signal switch_stmt_141_choice_1_291_start: Boolean;
        signal Xentry_292_symbol: Boolean;
        signal Xexit_293_symbol: Boolean;
        signal ack1_294_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_141_choice_1_291_start <= switch_stmt_141_x_xselect_x_xx_x285_symbol; -- control passed to block
        Xentry_292_symbol  <= switch_stmt_141_choice_1_291_start; -- transition branch_block_stmt_101/switch_stmt_141_choice_1/$entry
        ack1_294_symbol <= switch_stmt_141_branch_1_ack_1; -- transition branch_block_stmt_101/switch_stmt_141_choice_1/ack1
        Xexit_293_symbol <= ack1_294_symbol; -- transition branch_block_stmt_101/switch_stmt_141_choice_1/$exit
        switch_stmt_141_choice_1_291_symbol <= Xexit_293_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_101/switch_stmt_141_choice_1
      switch_stmt_141_choice_default_295: Block -- branch_block_stmt_101/switch_stmt_141_choice_default 
        signal switch_stmt_141_choice_default_295_start: Boolean;
        signal Xentry_296_symbol: Boolean;
        signal Xexit_297_symbol: Boolean;
        signal ack0_298_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_141_choice_default_295_start <= switch_stmt_141_x_xselect_x_xx_x285_symbol; -- control passed to block
        Xentry_296_symbol  <= switch_stmt_141_choice_default_295_start; -- transition branch_block_stmt_101/switch_stmt_141_choice_default/$entry
        ack0_298_symbol <= switch_stmt_141_branch_default_ack_0; -- transition branch_block_stmt_101/switch_stmt_141_choice_default/ack0
        Xexit_297_symbol <= ack0_298_symbol; -- transition branch_block_stmt_101/switch_stmt_141_choice_default/$exit
        switch_stmt_141_choice_default_295_symbol <= Xexit_297_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_101/switch_stmt_141_choice_default
      switch_stmt_141_choice_default_to_switch_stmt_141_x_xexit_x_xx_x299_symbol  <=  switch_stmt_141_choice_default_295_symbol; -- place branch_block_stmt_101/switch_stmt_141_choice_default_to_switch_stmt_141__exit__ (optimized away) 
      merge_stmt_102_dead_link_300: Block -- branch_block_stmt_101/merge_stmt_102_dead_link 
        signal merge_stmt_102_dead_link_300_start: Boolean;
        signal Xentry_301_symbol: Boolean;
        signal Xexit_302_symbol: Boolean;
        signal dead_transition_303_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_102_dead_link_300_start <= merge_stmt_102_x_xentry_x_xx_x8_symbol; -- control passed to block
        Xentry_301_symbol  <= merge_stmt_102_dead_link_300_start; -- transition branch_block_stmt_101/merge_stmt_102_dead_link/$entry
        dead_transition_303_symbol <= false;
        Xexit_302_symbol <= dead_transition_303_symbol; -- transition branch_block_stmt_101/merge_stmt_102_dead_link/$exit
        merge_stmt_102_dead_link_300_symbol <= Xexit_302_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_101/merge_stmt_102_dead_link
      merge_stmt_102_x_xentry_x_xx_xPhiReq_304: Block -- branch_block_stmt_101/merge_stmt_102__entry___PhiReq 
        signal merge_stmt_102_x_xentry_x_xx_xPhiReq_304_start: Boolean;
        signal Xentry_305_symbol: Boolean;
        signal Xexit_306_symbol: Boolean;
        signal phi_stmt_103_307_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_102_x_xentry_x_xx_xPhiReq_304_start <= merge_stmt_102_x_xentry_x_xx_x8_symbol; -- control passed to block
        Xentry_305_symbol  <= merge_stmt_102_x_xentry_x_xx_xPhiReq_304_start; -- transition branch_block_stmt_101/merge_stmt_102__entry___PhiReq/$entry
        phi_stmt_103_307: Block -- branch_block_stmt_101/merge_stmt_102__entry___PhiReq/phi_stmt_103 
          signal phi_stmt_103_307_start: Boolean;
          signal Xentry_308_symbol: Boolean;
          signal Xexit_309_symbol: Boolean;
          signal phi_stmt_103_req_310_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_103_307_start <= Xentry_305_symbol; -- control passed to block
          Xentry_308_symbol  <= phi_stmt_103_307_start; -- transition branch_block_stmt_101/merge_stmt_102__entry___PhiReq/phi_stmt_103/$entry
          phi_stmt_103_req_310_symbol <= Xentry_308_symbol; -- transition branch_block_stmt_101/merge_stmt_102__entry___PhiReq/phi_stmt_103/phi_stmt_103_req
          phi_stmt_103_req_0 <= phi_stmt_103_req_310_symbol; -- link to DP
          Xexit_309_symbol <= phi_stmt_103_req_310_symbol; -- transition branch_block_stmt_101/merge_stmt_102__entry___PhiReq/phi_stmt_103/$exit
          phi_stmt_103_307_symbol <= Xexit_309_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/merge_stmt_102__entry___PhiReq/phi_stmt_103
        Xexit_306_symbol <= phi_stmt_103_307_symbol; -- transition branch_block_stmt_101/merge_stmt_102__entry___PhiReq/$exit
        merge_stmt_102_x_xentry_x_xx_xPhiReq_304_symbol <= Xexit_306_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_101/merge_stmt_102__entry___PhiReq
      loopback_PhiReq_311: Block -- branch_block_stmt_101/loopback_PhiReq 
        signal loopback_PhiReq_311_start: Boolean;
        signal Xentry_312_symbol: Boolean;
        signal Xexit_313_symbol: Boolean;
        signal phi_stmt_103_314_symbol : Boolean;
        -- 
      begin -- 
        loopback_PhiReq_311_start <= loopback_290_symbol; -- control passed to block
        Xentry_312_symbol  <= loopback_PhiReq_311_start; -- transition branch_block_stmt_101/loopback_PhiReq/$entry
        phi_stmt_103_314: Block -- branch_block_stmt_101/loopback_PhiReq/phi_stmt_103 
          signal phi_stmt_103_314_start: Boolean;
          signal Xentry_315_symbol: Boolean;
          signal Xexit_316_symbol: Boolean;
          signal phi_stmt_103_req_317_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_103_314_start <= Xentry_312_symbol; -- control passed to block
          Xentry_315_symbol  <= phi_stmt_103_314_start; -- transition branch_block_stmt_101/loopback_PhiReq/phi_stmt_103/$entry
          phi_stmt_103_req_317_symbol <= Xentry_315_symbol; -- transition branch_block_stmt_101/loopback_PhiReq/phi_stmt_103/phi_stmt_103_req
          phi_stmt_103_req_1 <= phi_stmt_103_req_317_symbol; -- link to DP
          Xexit_316_symbol <= phi_stmt_103_req_317_symbol; -- transition branch_block_stmt_101/loopback_PhiReq/phi_stmt_103/$exit
          phi_stmt_103_314_symbol <= Xexit_316_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_101/loopback_PhiReq/phi_stmt_103
        Xexit_313_symbol <= phi_stmt_103_314_symbol; -- transition branch_block_stmt_101/loopback_PhiReq/$exit
        loopback_PhiReq_311_symbol <= Xexit_313_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_101/loopback_PhiReq
      merge_stmt_102_PhiReqMerge_318_symbol  <=  merge_stmt_102_x_xentry_x_xx_xPhiReq_304_symbol or loopback_PhiReq_311_symbol; -- place branch_block_stmt_101/merge_stmt_102_PhiReqMerge (optimized away) 
      merge_stmt_102_PhiAck_319: Block -- branch_block_stmt_101/merge_stmt_102_PhiAck 
        signal merge_stmt_102_PhiAck_319_start: Boolean;
        signal Xentry_320_symbol: Boolean;
        signal Xexit_321_symbol: Boolean;
        signal phi_stmt_103_ack_322_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_102_PhiAck_319_start <= merge_stmt_102_PhiReqMerge_318_symbol; -- control passed to block
        Xentry_320_symbol  <= merge_stmt_102_PhiAck_319_start; -- transition branch_block_stmt_101/merge_stmt_102_PhiAck/$entry
        phi_stmt_103_ack_322_symbol <= phi_stmt_103_ack_0; -- transition branch_block_stmt_101/merge_stmt_102_PhiAck/phi_stmt_103_ack
        Xexit_321_symbol <= phi_stmt_103_ack_322_symbol; -- transition branch_block_stmt_101/merge_stmt_102_PhiAck/$exit
        merge_stmt_102_PhiAck_319_symbol <= Xexit_321_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_101/merge_stmt_102_PhiAck
      Xexit_5_symbol <= branch_block_stmt_101_x_xexit_x_xx_x7_symbol; -- transition branch_block_stmt_101/$exit
      branch_block_stmt_101_3_symbol <= Xexit_5_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_101
    Xexit_2_symbol <= branch_block_stmt_101_3_symbol; -- transition $exit
    fin  <=  '1' when Xexit_2_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal array_obj_ref_118_final_offset : std_logic_vector(9 downto 0);
    signal array_obj_ref_118_offset_scale_factor_0 : std_logic_vector(9 downto 0);
    signal array_obj_ref_118_resized_base_address : std_logic_vector(9 downto 0);
    signal array_obj_ref_118_root_address : std_logic_vector(9 downto 0);
    signal array_obj_ref_122_final_offset : std_logic_vector(9 downto 0);
    signal array_obj_ref_122_offset_scale_factor_0 : std_logic_vector(9 downto 0);
    signal array_obj_ref_122_resized_base_address : std_logic_vector(9 downto 0);
    signal array_obj_ref_122_root_address : std_logic_vector(9 downto 0);
    signal cptr_119 : std_logic_vector(31 downto 0);
    signal cval_112 : std_logic_vector(7 downto 0);
    signal dptr_123 : std_logic_vector(31 downto 0);
    signal dval_115 : std_logic_vector(63 downto 0);
    signal expr_126_wire_constant : std_logic_vector(31 downto 0);
    signal expr_143_wire_constant : std_logic_vector(7 downto 0);
    signal expr_143_wire_constant_cmp : std_logic_vector(0 downto 0);
    signal expr_146_wire_constant : std_logic_vector(7 downto 0);
    signal expr_146_wire_constant_cmp : std_logic_vector(0 downto 0);
    signal nrxpktlength_128 : std_logic_vector(31 downto 0);
    signal ptr_deref_131_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_131_resized_base_address : std_logic_vector(9 downto 0);
    signal ptr_deref_131_root_address : std_logic_vector(9 downto 0);
    signal ptr_deref_131_wire : std_logic_vector(7 downto 0);
    signal ptr_deref_131_word_address_0 : std_logic_vector(9 downto 0);
    signal ptr_deref_131_word_offset_0 : std_logic_vector(9 downto 0);
    signal ptr_deref_135_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_135_resized_base_address : std_logic_vector(9 downto 0);
    signal ptr_deref_135_root_address : std_logic_vector(9 downto 0);
    signal ptr_deref_135_wire : std_logic_vector(63 downto 0);
    signal ptr_deref_135_word_address_0 : std_logic_vector(9 downto 0);
    signal ptr_deref_135_word_offset_0 : std_logic_vector(9 downto 0);
    signal rxpktlength_103 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_117_resized : std_logic_vector(9 downto 0);
    signal simple_obj_ref_117_scaled : std_logic_vector(9 downto 0);
    signal simple_obj_ref_121_resized : std_logic_vector(9 downto 0);
    signal simple_obj_ref_121_scaled : std_logic_vector(9 downto 0);
    signal type_cast_106_wire_constant : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    array_obj_ref_118_offset_scale_factor_0 <= "0000000001";
    array_obj_ref_122_offset_scale_factor_0 <= "0000000001";
    expr_126_wire_constant <= "00000000000000000000000000000001";
    expr_143_wire_constant <= "11111111";
    expr_146_wire_constant <= "00000000";
    ptr_deref_131_word_offset_0 <= "0000000000";
    ptr_deref_135_word_offset_0 <= "0000000000";
    type_cast_106_wire_constant <= "00000000000000000000000000000000";
    phi_stmt_103: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_106_wire_constant & nrxpktlength_128;
      req <= phi_stmt_103_req_0 & phi_stmt_103_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_103_ack_0,
          idata => idata,
          odata => rxpktlength_103,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_103
    array_obj_ref_118_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 10, flow_through => true ) 
      port map( din => ctrlptr, dout => array_obj_ref_118_resized_base_address, req => array_obj_ref_118_base_resize_req_0, ack => array_obj_ref_118_base_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_118_final_reg: RegisterBase --
      generic map(in_data_width => 10,out_data_width => 32, flow_through => false ) 
      port map( din => array_obj_ref_118_root_address, dout => cptr_119, req => array_obj_ref_118_final_reg_req_0, ack => array_obj_ref_118_final_reg_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_118_index_0_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 10, flow_through => true ) 
      port map( din => rxpktlength_103, dout => simple_obj_ref_117_resized, req => array_obj_ref_118_index_0_resize_req_0, ack => array_obj_ref_118_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_118_offset_inst: RegisterBase --
      generic map(in_data_width => 10,out_data_width => 10, flow_through => true ) 
      port map( din => simple_obj_ref_117_scaled, dout => array_obj_ref_118_final_offset, req => array_obj_ref_118_offset_inst_req_0, ack => array_obj_ref_118_offset_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_122_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 10, flow_through => true ) 
      port map( din => dataptr, dout => array_obj_ref_122_resized_base_address, req => array_obj_ref_122_base_resize_req_0, ack => array_obj_ref_122_base_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_122_final_reg: RegisterBase --
      generic map(in_data_width => 10,out_data_width => 32, flow_through => false ) 
      port map( din => array_obj_ref_122_root_address, dout => dptr_123, req => array_obj_ref_122_final_reg_req_0, ack => array_obj_ref_122_final_reg_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_122_index_0_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 10, flow_through => true ) 
      port map( din => rxpktlength_103, dout => simple_obj_ref_121_resized, req => array_obj_ref_122_index_0_resize_req_0, ack => array_obj_ref_122_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_122_offset_inst: RegisterBase --
      generic map(in_data_width => 10,out_data_width => 10, flow_through => true ) 
      port map( din => simple_obj_ref_121_scaled, dout => array_obj_ref_122_final_offset, req => array_obj_ref_122_offset_inst_req_0, ack => array_obj_ref_122_offset_inst_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_131_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 10, flow_through => true ) 
      port map( din => cptr_119, dout => ptr_deref_131_resized_base_address, req => ptr_deref_131_base_resize_req_0, ack => ptr_deref_131_base_resize_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_135_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 10, flow_through => true ) 
      port map( din => dptr_123, dout => ptr_deref_135_resized_base_address, req => ptr_deref_135_base_resize_req_0, ack => ptr_deref_135_base_resize_ack_0, clk => clk, reset => reset); -- 
    simple_obj_ref_138_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => false ) 
      port map( din => nrxpktlength_128, dout => pktlength, req => simple_obj_ref_138_inst_req_0, ack => simple_obj_ref_138_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_118_index_0_rename: Block -- 
      signal aggregated_sig: std_logic_vector(9 downto 0); --
    begin -- 
      array_obj_ref_118_index_0_rename_ack_0 <= array_obj_ref_118_index_0_rename_req_0;
      aggregated_sig <= simple_obj_ref_117_resized;
      simple_obj_ref_117_scaled <= aggregated_sig(9 downto 0);
      --
    end Block;
    array_obj_ref_122_index_0_rename: Block -- 
      signal aggregated_sig: std_logic_vector(9 downto 0); --
    begin -- 
      array_obj_ref_122_index_0_rename_ack_0 <= array_obj_ref_122_index_0_rename_req_0;
      aggregated_sig <= simple_obj_ref_121_resized;
      simple_obj_ref_121_scaled <= aggregated_sig(9 downto 0);
      --
    end Block;
    ptr_deref_131_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(9 downto 0); --
    begin -- 
      ptr_deref_131_addr_0_ack_0 <= ptr_deref_131_addr_0_req_0;
      aggregated_sig <= ptr_deref_131_root_address;
      ptr_deref_131_word_address_0 <= aggregated_sig(9 downto 0);
      --
    end Block;
    ptr_deref_131_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_131_gather_scatter_ack_0 <= ptr_deref_131_gather_scatter_req_0;
      aggregated_sig <= cval_112;
      ptr_deref_131_data_0 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_131_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(9 downto 0); --
    begin -- 
      ptr_deref_131_root_address_inst_ack_0 <= ptr_deref_131_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_131_resized_base_address;
      ptr_deref_131_root_address <= aggregated_sig(9 downto 0);
      --
    end Block;
    ptr_deref_135_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(9 downto 0); --
    begin -- 
      ptr_deref_135_addr_0_ack_0 <= ptr_deref_135_addr_0_req_0;
      aggregated_sig <= ptr_deref_135_root_address;
      ptr_deref_135_word_address_0 <= aggregated_sig(9 downto 0);
      --
    end Block;
    ptr_deref_135_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_135_gather_scatter_ack_0 <= ptr_deref_135_gather_scatter_req_0;
      aggregated_sig <= dval_115;
      ptr_deref_135_data_0 <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_135_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(9 downto 0); --
    begin -- 
      ptr_deref_135_root_address_inst_ack_0 <= ptr_deref_135_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_135_resized_base_address;
      ptr_deref_135_root_address <= aggregated_sig(9 downto 0);
      --
    end Block;
    switch_stmt_141_branch_0: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= expr_143_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_141_branch_0_req_0,
          ack0 => open,
          ack1 => switch_stmt_141_branch_0_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_141_branch_1: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= expr_146_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_141_branch_1_req_0,
          ack0 => open,
          ack1 => switch_stmt_141_branch_1_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_141_branch_default: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(1 downto 0);
      begin 
      condition_sig <= expr_143_wire_constant_cmp & expr_146_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 2)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_141_branch_default_req_0,
          ack0 => switch_stmt_141_branch_default_ack_0,
          ack1 => open,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : array_obj_ref_118_root_address_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(19 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= array_obj_ref_118_final_offset & array_obj_ref_118_resized_base_address;
      array_obj_ref_118_root_address <= data_out(9 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 10, 
          num_inputs    => 2,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 10,
          constant_operand => "0",
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => array_obj_ref_118_root_address_inst_req_0,
          ackL => array_obj_ref_118_root_address_inst_ack_0,
          reqR => array_obj_ref_118_root_address_inst_req_1,
          ackR => array_obj_ref_118_root_address_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : array_obj_ref_122_root_address_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(19 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= array_obj_ref_122_final_offset & array_obj_ref_122_resized_base_address;
      array_obj_ref_122_root_address <= data_out(9 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 10, 
          num_inputs    => 2,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 10,
          constant_operand => "0",
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => array_obj_ref_122_root_address_inst_req_0,
          ackL => array_obj_ref_122_root_address_inst_ack_0,
          reqR => array_obj_ref_122_root_address_inst_req_1,
          ackR => array_obj_ref_122_root_address_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : binary_127_inst 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= rxpktlength_103;
      nrxpktlength_128 <= data_out(31 downto 0);
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
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_127_inst_req_0,
          ackL => binary_127_inst_ack_0,
          reqR => binary_127_inst_req_1,
          ackR => binary_127_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : switch_stmt_141_select_expr_0 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= cval_112;
      expr_143_wire_constant_cmp <= data_out(0 downto 0);
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
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => switch_stmt_141_select_expr_0_req_0,
          ackL => switch_stmt_141_select_expr_0_ack_0,
          reqR => switch_stmt_141_select_expr_0_req_1,
          ackR => switch_stmt_141_select_expr_0_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : switch_stmt_141_select_expr_1 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= cval_112;
      expr_146_wire_constant_cmp <= data_out(0 downto 0);
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
          constant_operand => "00000000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => switch_stmt_141_select_expr_1_req_0,
          ackL => switch_stmt_141_select_expr_1_ack_0,
          reqR => switch_stmt_141_select_expr_1_req_1,
          ackR => switch_stmt_141_select_expr_1_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared store operator group (0) : ptr_deref_131_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(9 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_131_store_0_req_0;
      ptr_deref_131_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_131_store_0_req_1;
      ptr_deref_131_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_131_word_address_0;
      data_in <= ptr_deref_131_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 10,
        data_width => 8,
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
          maddr => memory_space_1_sr_addr(9 downto 0),
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
    -- shared store operator group (1) : ptr_deref_135_store_0 
    StoreGroup1: Block -- 
      signal addr_in: std_logic_vector(9 downto 0);
      signal data_in: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_135_store_0_req_0;
      ptr_deref_135_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_135_store_0_req_1;
      ptr_deref_135_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_135_word_address_0;
      data_in <= ptr_deref_135_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 10,
        data_width => 64,
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
          maddr => memory_space_2_sr_addr(9 downto 0),
          mdata => memory_space_2_sr_data(63 downto 0),
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
    end Block; -- store group 1
    -- shared inport operator group (0) : simple_obj_ref_111_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_111_inst_req_0;
      simple_obj_ref_111_inst_ack_0 <= ack(0);
      cval_112 <= data_out(7 downto 0);
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
    -- shared inport operator group (1) : simple_obj_ref_114_inst 
    InportGroup1: Block -- 
      signal data_out: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_114_inst_req_0;
      simple_obj_ref_114_inst_ack_0 <= ack(0);
      dval_115 <= data_out(63 downto 0);
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
  -- interface signals to connect to memory space memory_space_1
  signal memory_space_1_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_1_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_1_lr_addr : std_logic_vector(9 downto 0);
  signal memory_space_1_lr_tag : std_logic_vector(0 downto 0);
  signal memory_space_1_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_1_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_1_lc_data : std_logic_vector(7 downto 0);
  signal memory_space_1_lc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_1_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_1_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_1_sr_addr : std_logic_vector(9 downto 0);
  signal memory_space_1_sr_data : std_logic_vector(7 downto 0);
  signal memory_space_1_sr_tag : std_logic_vector(0 downto 0);
  signal memory_space_1_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_1_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_1_sc_tag :  std_logic_vector(0 downto 0);
  -- interface signals to connect to memory space memory_space_2
  signal memory_space_2_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_2_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_2_lr_addr : std_logic_vector(9 downto 0);
  signal memory_space_2_lr_tag : std_logic_vector(0 downto 0);
  signal memory_space_2_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_2_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_2_lc_data : std_logic_vector(63 downto 0);
  signal memory_space_2_lc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_2_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_2_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_2_sr_addr : std_logic_vector(9 downto 0);
  signal memory_space_2_sr_data : std_logic_vector(63 downto 0);
  signal memory_space_2_sr_tag : std_logic_vector(0 downto 0);
  signal memory_space_2_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_2_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_2_sc_tag :  std_logic_vector(0 downto 0);
  -- declarations related to module get_packet
  component get_packet is -- 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      free_index_pipe_pipe_read_req : out  std_logic_vector(0 downto 0);
      free_index_pipe_pipe_read_ack : in   std_logic_vector(0 downto 0);
      free_index_pipe_pipe_read_data : in   std_logic_vector(31 downto 0);
      send_msg_pipe_write_req : out  std_logic_vector(0 downto 0);
      send_msg_pipe_write_ack : in   std_logic_vector(0 downto 0);
      send_msg_pipe_write_data : out  std_logic_vector(31 downto 0);
      store_packet_call_reqs : out  std_logic_vector(0 downto 0);
      store_packet_call_acks : in   std_logic_vector(0 downto 0);
      store_packet_call_data : out  std_logic_vector(63 downto 0);
      store_packet_call_tag  :  out  std_logic_vector(0 downto 0);
      store_packet_return_reqs : out  std_logic_vector(0 downto 0);
      store_packet_return_acks : in   std_logic_vector(0 downto 0);
      store_packet_return_data : in   std_logic_vector(31 downto 0);
      store_packet_return_tag :  in   std_logic_vector(0 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- argument signals for module get_packet
  signal get_packet_tag_in    : std_logic_vector(0 downto 0);
  signal get_packet_tag_out   : std_logic_vector(0 downto 0);
  signal get_packet_start : std_logic;
  signal get_packet_fin   : std_logic;
  -- declarations related to module remove_packet
  component remove_packet is -- 
    port ( -- 
      ctrlptr : in  std_logic_vector(31 downto 0);
      dataptr : in  std_logic_vector(31 downto 0);
      pktlength : in  std_logic_vector(31 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      memory_space_1_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_1_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_lr_addr : out  std_logic_vector(9 downto 0);
      memory_space_1_lr_tag :  out  std_logic_vector(0 downto 0);
      memory_space_1_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_1_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_lc_data : in   std_logic_vector(7 downto 0);
      memory_space_1_lc_tag :  in  std_logic_vector(0 downto 0);
      memory_space_2_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_2_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_lr_addr : out  std_logic_vector(9 downto 0);
      memory_space_2_lr_tag :  out  std_logic_vector(0 downto 0);
      memory_space_2_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_2_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_lc_data : in   std_logic_vector(63 downto 0);
      memory_space_2_lc_tag :  in  std_logic_vector(0 downto 0);
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
  -- argument signals for module remove_packet
  signal remove_packet_ctrlptr :  std_logic_vector(31 downto 0);
  signal remove_packet_dataptr :  std_logic_vector(31 downto 0);
  signal remove_packet_pktlength :  std_logic_vector(31 downto 0);
  signal remove_packet_in_args    : std_logic_vector(95 downto 0);
  signal remove_packet_tag_in    : std_logic_vector(0 downto 0);
  signal remove_packet_tag_out   : std_logic_vector(0 downto 0);
  signal remove_packet_start : std_logic;
  signal remove_packet_fin   : std_logic;
  -- caller side aggregated signals for module remove_packet
  signal remove_packet_call_reqs: std_logic_vector(0 downto 0);
  signal remove_packet_call_acks: std_logic_vector(0 downto 0);
  signal remove_packet_return_reqs: std_logic_vector(0 downto 0);
  signal remove_packet_return_acks: std_logic_vector(0 downto 0);
  signal remove_packet_call_data: std_logic_vector(95 downto 0);
  signal remove_packet_call_tag: std_logic_vector(0 downto 0);
  signal remove_packet_return_data: std_logic_vector(-1 downto 0);
  signal remove_packet_return_tag: std_logic_vector(0 downto 0);
  -- declarations related to module send_packet
  component send_packet is -- 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      send_msg_pipe_read_req : out  std_logic_vector(0 downto 0);
      send_msg_pipe_read_ack : in   std_logic_vector(0 downto 0);
      send_msg_pipe_read_data : in   std_logic_vector(31 downto 0);
      free_index_pipe_pipe_write_req : out  std_logic_vector(0 downto 0);
      free_index_pipe_pipe_write_ack : in   std_logic_vector(0 downto 0);
      free_index_pipe_pipe_write_data : out  std_logic_vector(31 downto 0);
      remove_packet_call_reqs : out  std_logic_vector(0 downto 0);
      remove_packet_call_acks : in   std_logic_vector(0 downto 0);
      remove_packet_call_data : out  std_logic_vector(95 downto 0);
      remove_packet_call_tag  :  out  std_logic_vector(0 downto 0);
      remove_packet_return_reqs : out  std_logic_vector(0 downto 0);
      remove_packet_return_acks : in   std_logic_vector(0 downto 0);
      remove_packet_return_tag :  in   std_logic_vector(0 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- argument signals for module send_packet
  signal send_packet_tag_in    : std_logic_vector(0 downto 0);
  signal send_packet_tag_out   : std_logic_vector(0 downto 0);
  signal send_packet_start : std_logic;
  signal send_packet_fin   : std_logic;
  -- declarations related to module store_packet
  component store_packet is -- 
    port ( -- 
      ctrlptr : in  std_logic_vector(31 downto 0);
      dataptr : in  std_logic_vector(31 downto 0);
      pktlength : out  std_logic_vector(31 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      memory_space_1_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_1_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_sr_addr : out  std_logic_vector(9 downto 0);
      memory_space_1_sr_data : out  std_logic_vector(7 downto 0);
      memory_space_1_sr_tag :  out  std_logic_vector(0 downto 0);
      memory_space_1_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_1_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_sc_tag :  in  std_logic_vector(0 downto 0);
      memory_space_2_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_2_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_sr_addr : out  std_logic_vector(9 downto 0);
      memory_space_2_sr_data : out  std_logic_vector(63 downto 0);
      memory_space_2_sr_tag :  out  std_logic_vector(0 downto 0);
      memory_space_2_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_2_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_sc_tag :  in  std_logic_vector(0 downto 0);
      in_ctrl_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_ctrl_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_ctrl_pipe_read_data : in   std_logic_vector(7 downto 0);
      in_data_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_data_pipe_read_data : in   std_logic_vector(63 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- argument signals for module store_packet
  signal store_packet_ctrlptr :  std_logic_vector(31 downto 0);
  signal store_packet_dataptr :  std_logic_vector(31 downto 0);
  signal store_packet_pktlength :  std_logic_vector(31 downto 0);
  signal store_packet_in_args    : std_logic_vector(63 downto 0);
  signal store_packet_out_args   : std_logic_vector(31 downto 0);
  signal store_packet_tag_in    : std_logic_vector(0 downto 0);
  signal store_packet_tag_out   : std_logic_vector(0 downto 0);
  signal store_packet_start : std_logic;
  signal store_packet_fin   : std_logic;
  -- caller side aggregated signals for module store_packet
  signal store_packet_call_reqs: std_logic_vector(0 downto 0);
  signal store_packet_call_acks: std_logic_vector(0 downto 0);
  signal store_packet_return_reqs: std_logic_vector(0 downto 0);
  signal store_packet_return_acks: std_logic_vector(0 downto 0);
  signal store_packet_call_data: std_logic_vector(63 downto 0);
  signal store_packet_call_tag: std_logic_vector(0 downto 0);
  signal store_packet_return_data: std_logic_vector(31 downto 0);
  signal store_packet_return_tag: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe free_index_pipe
  signal free_index_pipe_pipe_write_data: std_logic_vector(31 downto 0);
  signal free_index_pipe_pipe_write_req: std_logic_vector(0 downto 0);
  signal free_index_pipe_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe free_index_pipe
  signal free_index_pipe_pipe_read_data: std_logic_vector(31 downto 0);
  signal free_index_pipe_pipe_read_req: std_logic_vector(0 downto 0);
  signal free_index_pipe_pipe_read_ack: std_logic_vector(0 downto 0);
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
  -- aggregate signals for write to pipe send_msg
  signal send_msg_pipe_write_data: std_logic_vector(31 downto 0);
  signal send_msg_pipe_write_req: std_logic_vector(0 downto 0);
  signal send_msg_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe send_msg
  signal send_msg_pipe_read_data: std_logic_vector(31 downto 0);
  signal send_msg_pipe_read_req: std_logic_vector(0 downto 0);
  signal send_msg_pipe_read_ack: std_logic_vector(0 downto 0);
  -- 
begin -- 
  -- module get_packet
  get_packet_instance:get_packet-- 
    port map(-- 
      start => get_packet_start,
      fin => get_packet_fin,
      clk => clk,
      reset => reset,
      free_index_pipe_pipe_read_req => free_index_pipe_pipe_read_req(0 downto 0),
      free_index_pipe_pipe_read_ack => free_index_pipe_pipe_read_ack(0 downto 0),
      free_index_pipe_pipe_read_data => free_index_pipe_pipe_read_data(31 downto 0),
      send_msg_pipe_write_req => send_msg_pipe_write_req(0 downto 0),
      send_msg_pipe_write_ack => send_msg_pipe_write_ack(0 downto 0),
      send_msg_pipe_write_data => send_msg_pipe_write_data(31 downto 0),
      store_packet_call_reqs => store_packet_call_reqs(0 downto 0),
      store_packet_call_acks => store_packet_call_acks(0 downto 0),
      store_packet_call_data => store_packet_call_data(63 downto 0),
      store_packet_call_tag => store_packet_call_tag(0 downto 0),
      store_packet_return_reqs => store_packet_return_reqs(0 downto 0),
      store_packet_return_acks => store_packet_return_acks(0 downto 0),
      store_packet_return_data => store_packet_return_data(31 downto 0),
      store_packet_return_tag => store_packet_return_tag(0 downto 0),
      tag_in => get_packet_tag_in,
      tag_out => get_packet_tag_out-- 
    ); -- 
  -- module will be run forever 
  get_packet_tag_in <= (others => '0');
  get_packet_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start => get_packet_start, fin => get_packet_fin);
  -- module remove_packet
  remove_packet_ctrlptr <= remove_packet_in_args(95 downto 64);
  remove_packet_dataptr <= remove_packet_in_args(63 downto 32);
  remove_packet_pktlength <= remove_packet_in_args(31 downto 0);
  -- call arbiter for module remove_packet
  remove_packet_arbiter: CallArbiterUnitaryNoOutargs -- 
    generic map( --
      num_reqs => 1,
      call_data_width => 96,
      callee_tag_length => 1,
      caller_tag_length => 1--
    )
    port map(-- 
      call_reqs => remove_packet_call_reqs,
      call_acks => remove_packet_call_acks,
      return_reqs => remove_packet_return_reqs,
      return_acks => remove_packet_return_acks,
      call_data  => remove_packet_call_data,
      call_tag  => remove_packet_call_tag,
      return_tag  => remove_packet_return_tag,
      call_in_tag => remove_packet_tag_in,
      call_out_tag => remove_packet_tag_out,
      call_start => remove_packet_start,
      call_fin => remove_packet_fin,
      call_in_args => remove_packet_in_args,
      clk => clk, 
      reset => reset --
    ); --
  remove_packet_instance:remove_packet-- 
    port map(-- 
      ctrlptr => remove_packet_ctrlptr,
      dataptr => remove_packet_dataptr,
      pktlength => remove_packet_pktlength,
      start => remove_packet_start,
      fin => remove_packet_fin,
      clk => clk,
      reset => reset,
      memory_space_1_lr_req => memory_space_1_lr_req(0 downto 0),
      memory_space_1_lr_ack => memory_space_1_lr_ack(0 downto 0),
      memory_space_1_lr_addr => memory_space_1_lr_addr(9 downto 0),
      memory_space_1_lr_tag => memory_space_1_lr_tag(0 downto 0),
      memory_space_1_lc_req => memory_space_1_lc_req(0 downto 0),
      memory_space_1_lc_ack => memory_space_1_lc_ack(0 downto 0),
      memory_space_1_lc_data => memory_space_1_lc_data(7 downto 0),
      memory_space_1_lc_tag => memory_space_1_lc_tag(0 downto 0),
      memory_space_2_lr_req => memory_space_2_lr_req(0 downto 0),
      memory_space_2_lr_ack => memory_space_2_lr_ack(0 downto 0),
      memory_space_2_lr_addr => memory_space_2_lr_addr(9 downto 0),
      memory_space_2_lr_tag => memory_space_2_lr_tag(0 downto 0),
      memory_space_2_lc_req => memory_space_2_lc_req(0 downto 0),
      memory_space_2_lc_ack => memory_space_2_lc_ack(0 downto 0),
      memory_space_2_lc_data => memory_space_2_lc_data(63 downto 0),
      memory_space_2_lc_tag => memory_space_2_lc_tag(0 downto 0),
      out_ctrl_pipe_write_req => out_ctrl_pipe_write_req(0 downto 0),
      out_ctrl_pipe_write_ack => out_ctrl_pipe_write_ack(0 downto 0),
      out_ctrl_pipe_write_data => out_ctrl_pipe_write_data(7 downto 0),
      out_data_pipe_write_req => out_data_pipe_write_req(0 downto 0),
      out_data_pipe_write_ack => out_data_pipe_write_ack(0 downto 0),
      out_data_pipe_write_data => out_data_pipe_write_data(63 downto 0),
      tag_in => remove_packet_tag_in,
      tag_out => remove_packet_tag_out-- 
    ); -- 
  -- module send_packet
  send_packet_instance:send_packet-- 
    port map(-- 
      start => send_packet_start,
      fin => send_packet_fin,
      clk => clk,
      reset => reset,
      send_msg_pipe_read_req => send_msg_pipe_read_req(0 downto 0),
      send_msg_pipe_read_ack => send_msg_pipe_read_ack(0 downto 0),
      send_msg_pipe_read_data => send_msg_pipe_read_data(31 downto 0),
      free_index_pipe_pipe_write_req => free_index_pipe_pipe_write_req(0 downto 0),
      free_index_pipe_pipe_write_ack => free_index_pipe_pipe_write_ack(0 downto 0),
      free_index_pipe_pipe_write_data => free_index_pipe_pipe_write_data(31 downto 0),
      remove_packet_call_reqs => remove_packet_call_reqs(0 downto 0),
      remove_packet_call_acks => remove_packet_call_acks(0 downto 0),
      remove_packet_call_data => remove_packet_call_data(95 downto 0),
      remove_packet_call_tag => remove_packet_call_tag(0 downto 0),
      remove_packet_return_reqs => remove_packet_return_reqs(0 downto 0),
      remove_packet_return_acks => remove_packet_return_acks(0 downto 0),
      remove_packet_return_tag => remove_packet_return_tag(0 downto 0),
      tag_in => send_packet_tag_in,
      tag_out => send_packet_tag_out-- 
    ); -- 
  -- module will be run forever 
  send_packet_tag_in <= (others => '0');
  send_packet_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start => send_packet_start, fin => send_packet_fin);
  -- module store_packet
  store_packet_ctrlptr <= store_packet_in_args(63 downto 32);
  store_packet_dataptr <= store_packet_in_args(31 downto 0);
  store_packet_out_args <= store_packet_pktlength ;
  -- call arbiter for module store_packet
  store_packet_arbiter: CallArbiterUnitary -- 
    generic map( --
      num_reqs => 1,
      call_data_width => 64,
      return_data_width => 32,
      callee_tag_length => 1,
      caller_tag_length => 1--
    )
    port map(-- 
      call_reqs => store_packet_call_reqs,
      call_acks => store_packet_call_acks,
      return_reqs => store_packet_return_reqs,
      return_acks => store_packet_return_acks,
      call_data  => store_packet_call_data,
      call_tag  => store_packet_call_tag,
      return_tag  => store_packet_return_tag,
      call_in_tag => store_packet_tag_in,
      call_out_tag => store_packet_tag_out,
      return_data =>store_packet_return_data,
      call_start => store_packet_start,
      call_fin => store_packet_fin,
      call_in_args => store_packet_in_args,
      call_out_args => store_packet_out_args,
      clk => clk, 
      reset => reset --
    ); --
  store_packet_instance:store_packet-- 
    port map(-- 
      ctrlptr => store_packet_ctrlptr,
      dataptr => store_packet_dataptr,
      pktlength => store_packet_pktlength,
      start => store_packet_start,
      fin => store_packet_fin,
      clk => clk,
      reset => reset,
      memory_space_1_sr_req => memory_space_1_sr_req(0 downto 0),
      memory_space_1_sr_ack => memory_space_1_sr_ack(0 downto 0),
      memory_space_1_sr_addr => memory_space_1_sr_addr(9 downto 0),
      memory_space_1_sr_data => memory_space_1_sr_data(7 downto 0),
      memory_space_1_sr_tag => memory_space_1_sr_tag(0 downto 0),
      memory_space_1_sc_req => memory_space_1_sc_req(0 downto 0),
      memory_space_1_sc_ack => memory_space_1_sc_ack(0 downto 0),
      memory_space_1_sc_tag => memory_space_1_sc_tag(0 downto 0),
      memory_space_2_sr_req => memory_space_2_sr_req(0 downto 0),
      memory_space_2_sr_ack => memory_space_2_sr_ack(0 downto 0),
      memory_space_2_sr_addr => memory_space_2_sr_addr(9 downto 0),
      memory_space_2_sr_data => memory_space_2_sr_data(63 downto 0),
      memory_space_2_sr_tag => memory_space_2_sr_tag(0 downto 0),
      memory_space_2_sc_req => memory_space_2_sc_req(0 downto 0),
      memory_space_2_sc_ack => memory_space_2_sc_ack(0 downto 0),
      memory_space_2_sc_tag => memory_space_2_sc_tag(0 downto 0),
      in_ctrl_pipe_read_req => in_ctrl_pipe_read_req(0 downto 0),
      in_ctrl_pipe_read_ack => in_ctrl_pipe_read_ack(0 downto 0),
      in_ctrl_pipe_read_data => in_ctrl_pipe_read_data(7 downto 0),
      in_data_pipe_read_req => in_data_pipe_read_req(0 downto 0),
      in_data_pipe_read_ack => in_data_pipe_read_ack(0 downto 0),
      in_data_pipe_read_data => in_data_pipe_read_data(63 downto 0),
      tag_in => store_packet_tag_in,
      tag_out => store_packet_tag_out-- 
    ); -- 
  free_index_pipe_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      depth => 1 --
    )
    port map( -- 
      read_req => free_index_pipe_pipe_read_req,
      read_ack => free_index_pipe_pipe_read_ack,
      read_data => free_index_pipe_pipe_read_data,
      write_req => free_index_pipe_pipe_write_req,
      write_ack => free_index_pipe_pipe_write_ack,
      write_data => free_index_pipe_pipe_write_data,
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
  send_msg_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      depth => 1 --
    )
    port map( -- 
      read_req => send_msg_pipe_read_req,
      read_ack => send_msg_pipe_read_ack,
      read_data => send_msg_pipe_read_data,
      write_req => send_msg_pipe_write_req,
      write_ack => send_msg_pipe_write_ack,
      write_data => send_msg_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  MemorySpace_memory_space_1: memory_subsystem -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 10,
      data_width => 8,
      tag_width => 1,
      number_of_banks => 1,
      mux_degree => 2,
      demux_degree => 2,
      base_bank_addr_width => 10,
      base_bank_data_width => 8
      ) -- 
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
  MemorySpace_memory_space_2: memory_subsystem -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 10,
      data_width => 64,
      tag_width => 1,
      number_of_banks => 1,
      mux_degree => 2,
      demux_degree => 2,
      base_bank_addr_width => 10,
      base_bank_data_width => 64
      ) -- 
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
