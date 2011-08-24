-- VHDL produced by vc2vhdl from virtual circuit (vc) description 
library ieee;
use ieee.std_logic_1164.all;
package vc_system_package is -- 
  constant R1_base_address : std_logic_vector(0 downto 0) := "0";
  constant R2_base_address : std_logic_vector(0 downto 0) := "0";
  constant R3_base_address : std_logic_vector(0 downto 0) := "0";
  constant frame_base_address : std_logic_vector(0 downto 0) := "0";
  constant key_base_address : std_logic_vector(1 downto 0) := "00";
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
entity a5init is -- 
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
    memory_space_2_lr_addr : out  std_logic_vector(0 downto 0);
    memory_space_2_lr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_2_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_2_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_2_lc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_0_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_0_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_lr_addr : out  std_logic_vector(0 downto 0);
    memory_space_0_lr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_0_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_0_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_0_lc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_1_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_1_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_lr_addr : out  std_logic_vector(0 downto 0);
    memory_space_1_lr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_1_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_1_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_1_lc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_3_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_3_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_3_lr_addr : out  std_logic_vector(1 downto 0);
    memory_space_3_lr_tag :  out  std_logic_vector(0 downto 0);
    memory_space_3_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_3_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_3_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_3_lc_tag :  in  std_logic_vector(0 downto 0);
    memory_space_4_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_4_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_4_lr_addr : out  std_logic_vector(0 downto 0);
    memory_space_4_lr_tag :  out  std_logic_vector(0 downto 0);
    memory_space_4_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_4_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_4_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_4_lc_tag :  in  std_logic_vector(0 downto 0);
    memory_space_2_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_2_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_sr_addr : out  std_logic_vector(0 downto 0);
    memory_space_2_sr_data : out  std_logic_vector(31 downto 0);
    memory_space_2_sr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_2_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_2_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_sc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_0_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_0_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_sr_addr : out  std_logic_vector(0 downto 0);
    memory_space_0_sr_data : out  std_logic_vector(31 downto 0);
    memory_space_0_sr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_0_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_0_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_sc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_1_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_1_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_sr_addr : out  std_logic_vector(0 downto 0);
    memory_space_1_sr_data : out  std_logic_vector(31 downto 0);
    memory_space_1_sr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_1_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_1_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_sc_tag :  in  std_logic_vector(1 downto 0);
    a5reg_call_reqs : out  std_logic_vector(0 downto 0);
    a5reg_call_acks : in   std_logic_vector(0 downto 0);
    a5reg_call_tag  :  out  std_logic_vector(0 downto 0);
    a5reg_return_reqs : out  std_logic_vector(0 downto 0);
    a5reg_return_acks : in   std_logic_vector(0 downto 0);
    a5reg_return_data : in   std_logic_vector(31 downto 0);
    a5reg_return_tag :  in   std_logic_vector(0 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
  );
  -- 
end entity a5init;
architecture Default of a5init is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal start_req_symbol: Boolean;
  signal start_ack_symbol: Boolean;
  signal fin_req_symbol: Boolean;
  signal fin_ack_symbol: Boolean;
  signal tag_push, tag_pop: std_logic; 
  signal start_ack_sig, fin_ack_sig: std_logic; 
  -- output port buffer signals
  signal a5init_CP_1104_start: Boolean;
  -- links between control-path and data-path
  signal binary_960_inst_req_0 : boolean;
  signal simple_obj_ref_902_gather_scatter_ack_0 : boolean;
  signal binary_960_inst_req_1 : boolean;
  signal type_cast_931_inst_ack_0 : boolean;
  signal simple_obj_ref_902_load_0_req_0 : boolean;
  signal phi_stmt_648_ack_0 : boolean;
  signal simple_obj_ref_902_load_0_req_1 : boolean;
  signal simple_obj_ref_902_load_0_ack_0 : boolean;
  signal binary_971_inst_ack_1 : boolean;
  signal binary_1006_inst_req_1 : boolean;
  signal simple_obj_ref_898_store_0_req_0 : boolean;
  signal binary_989_inst_ack_0 : boolean;
  signal binary_882_inst_ack_1 : boolean;
  signal binary_989_inst_req_1 : boolean;
  signal type_cast_657_inst_ack_0 : boolean;
  signal simple_obj_ref_898_store_0_ack_0 : boolean;
  signal binary_971_inst_req_1 : boolean;
  signal binary_955_inst_ack_1 : boolean;
  signal binary_971_inst_ack_0 : boolean;
  signal simple_obj_ref_905_load_0_req_0 : boolean;
  signal if_stmt_885_branch_ack_1 : boolean;
  signal simple_obj_ref_898_store_0_req_1 : boolean;
  signal binary_1016_inst_req_1 : boolean;
  signal binary_882_inst_req_1 : boolean;
  signal binary_995_inst_req_1 : boolean;
  signal binary_971_inst_req_0 : boolean;
  signal binary_1011_inst_req_0 : boolean;
  signal binary_965_inst_req_0 : boolean;
  signal binary_960_inst_ack_0 : boolean;
  signal binary_955_inst_req_1 : boolean;
  signal if_stmt_885_branch_ack_0 : boolean;
  signal simple_obj_ref_902_gather_scatter_req_0 : boolean;
  signal binary_882_inst_ack_0 : boolean;
  signal simple_obj_ref_905_load_0_ack_0 : boolean;
  signal binary_989_inst_ack_1 : boolean;
  signal binary_955_inst_ack_0 : boolean;
  signal binary_882_inst_req_0 : boolean;
  signal simple_obj_ref_898_store_0_ack_1 : boolean;
  signal simple_obj_ref_898_gather_scatter_ack_0 : boolean;
  signal phi_stmt_654_req_0 : boolean;
  signal binary_955_inst_req_0 : boolean;
  signal binary_1001_inst_ack_0 : boolean;
  signal binary_995_inst_ack_1 : boolean;
  signal simple_obj_ref_898_gather_scatter_req_0 : boolean;
  signal binary_1001_inst_req_0 : boolean;
  signal phi_stmt_934_req_0 : boolean;
  signal binary_724_inst_req_0 : boolean;
  signal binary_706_inst_req_0 : boolean;
  signal binary_706_inst_ack_0 : boolean;
  signal binary_706_inst_req_1 : boolean;
  signal binary_752_inst_req_1 : boolean;
  signal binary_724_inst_ack_0 : boolean;
  signal binary_706_inst_ack_1 : boolean;
  signal binary_724_inst_req_1 : boolean;
  signal simple_obj_ref_911_gather_scatter_ack_0 : boolean;
  signal binary_724_inst_ack_1 : boolean;
  signal binary_757_inst_req_0 : boolean;
  signal binary_977_inst_ack_1 : boolean;
  signal binary_1011_inst_req_1 : boolean;
  signal binary_1011_inst_ack_1 : boolean;
  signal binary_1006_inst_req_0 : boolean;
  signal simple_obj_ref_902_load_0_ack_1 : boolean;
  signal phi_stmt_934_ack_0 : boolean;
  signal binary_977_inst_req_1 : boolean;
  signal if_stmt_885_branch_req_0 : boolean;
  signal phi_stmt_642_ack_0 : boolean;
  signal binary_950_inst_ack_1 : boolean;
  signal binary_950_inst_req_1 : boolean;
  signal binary_977_inst_ack_0 : boolean;
  signal binary_950_inst_ack_0 : boolean;
  signal binary_950_inst_req_0 : boolean;
  signal type_cast_931_inst_req_0 : boolean;
  signal simple_obj_ref_905_load_0_req_1 : boolean;
  signal binary_989_inst_req_0 : boolean;
  signal binary_944_inst_ack_1 : boolean;
  signal type_cast_657_inst_req_0 : boolean;
  signal binary_876_inst_ack_1 : boolean;
  signal simple_obj_ref_895_store_0_ack_1 : boolean;
  signal simple_obj_ref_892_gather_scatter_ack_0 : boolean;
  signal binary_876_inst_req_1 : boolean;
  signal simple_obj_ref_895_store_0_req_1 : boolean;
  signal binary_876_inst_req_0 : boolean;
  signal binary_944_inst_req_1 : boolean;
  signal binary_876_inst_ack_0 : boolean;
  signal binary_944_inst_ack_0 : boolean;
  signal binary_944_inst_req_0 : boolean;
  signal binary_977_inst_req_0 : boolean;
  signal binary_995_inst_ack_0 : boolean;
  signal binary_1006_inst_ack_1 : boolean;
  signal type_cast_651_inst_ack_0 : boolean;
  signal binary_983_inst_ack_1 : boolean;
  signal binary_1001_inst_ack_1 : boolean;
  signal binary_718_inst_req_1 : boolean;
  signal binary_718_inst_ack_1 : boolean;
  signal binary_747_inst_req_1 : boolean;
  signal simple_obj_ref_892_store_0_req_0 : boolean;
  signal binary_747_inst_ack_1 : boolean;
  signal binary_742_inst_req_0 : boolean;
  signal binary_742_inst_ack_0 : boolean;
  signal binary_742_inst_req_1 : boolean;
  signal binary_742_inst_ack_1 : boolean;
  signal phi_stmt_635_ack_0 : boolean;
  signal binary_701_inst_req_0 : boolean;
  signal binary_701_inst_ack_0 : boolean;
  signal binary_701_inst_req_1 : boolean;
  signal binary_701_inst_ack_1 : boolean;
  signal binary_995_inst_req_0 : boolean;
  signal binary_752_inst_req_0 : boolean;
  signal binary_752_inst_ack_0 : boolean;
  signal simple_obj_ref_911_load_0_req_0 : boolean;
  signal binary_752_inst_ack_1 : boolean;
  signal binary_757_inst_ack_0 : boolean;
  signal simple_obj_ref_911_gather_scatter_req_0 : boolean;
  signal binary_712_inst_req_0 : boolean;
  signal binary_712_inst_ack_0 : boolean;
  signal simple_obj_ref_911_load_0_ack_1 : boolean;
  signal binary_712_inst_req_1 : boolean;
  signal binary_730_inst_req_0 : boolean;
  signal binary_712_inst_ack_1 : boolean;
  signal binary_730_inst_ack_0 : boolean;
  signal binary_730_inst_req_1 : boolean;
  signal binary_730_inst_ack_1 : boolean;
  signal binary_870_inst_ack_1 : boolean;
  signal simple_obj_ref_911_load_0_req_1 : boolean;
  signal binary_870_inst_ack_0 : boolean;
  signal binary_757_inst_req_1 : boolean;
  signal binary_757_inst_ack_1 : boolean;
  signal binary_736_inst_req_0 : boolean;
  signal binary_736_inst_ack_0 : boolean;
  signal binary_870_inst_req_1 : boolean;
  signal binary_736_inst_req_1 : boolean;
  signal binary_718_inst_req_0 : boolean;
  signal binary_736_inst_ack_1 : boolean;
  signal binary_747_inst_ack_0 : boolean;
  signal binary_718_inst_ack_0 : boolean;
  signal binary_747_inst_req_0 : boolean;
  signal simple_obj_ref_911_load_0_ack_0 : boolean;
  signal binary_960_inst_ack_1 : boolean;
  signal binary_1001_inst_req_1 : boolean;
  signal phi_stmt_922_ack_0 : boolean;
  signal binary_1051_inst_req_1 : boolean;
  signal binary_1051_inst_ack_1 : boolean;
  signal simple_obj_ref_892_store_0_ack_0 : boolean;
  signal type_cast_651_inst_req_0 : boolean;
  signal simple_obj_ref_905_load_0_ack_1 : boolean;
  signal binary_983_inst_req_0 : boolean;
  signal binary_1033_inst_req_1 : boolean;
  signal binary_1033_inst_ack_1 : boolean;
  signal binary_1039_inst_req_1 : boolean;
  signal binary_1039_inst_ack_1 : boolean;
  signal binary_1045_inst_req_1 : boolean;
  signal type_cast_645_inst_req_0 : boolean;
  signal binary_1045_inst_ack_1 : boolean;
  signal type_cast_925_inst_ack_0 : boolean;
  signal binary_1022_inst_req_0 : boolean;
  signal simple_obj_ref_892_gather_scatter_req_0 : boolean;
  signal binary_1027_inst_req_0 : boolean;
  signal binary_1045_inst_req_0 : boolean;
  signal binary_1045_inst_ack_0 : boolean;
  signal type_cast_645_inst_ack_0 : boolean;
  signal binary_1027_inst_ack_0 : boolean;
  signal phi_stmt_928_ack_0 : boolean;
  signal binary_1027_inst_req_1 : boolean;
  signal phi_stmt_642_req_0 : boolean;
  signal binary_1027_inst_ack_1 : boolean;
  signal binary_1033_inst_req_0 : boolean;
  signal binary_1006_inst_ack_0 : boolean;
  signal phi_stmt_648_req_0 : boolean;
  signal binary_1039_inst_req_0 : boolean;
  signal simple_obj_ref_892_store_0_req_1 : boolean;
  signal binary_983_inst_req_1 : boolean;
  signal binary_1016_inst_ack_1 : boolean;
  signal phi_stmt_915_ack_0 : boolean;
  signal binary_983_inst_ack_0 : boolean;
  signal binary_1033_inst_ack_0 : boolean;
  signal phi_stmt_922_req_0 : boolean;
  signal simple_obj_ref_892_store_0_ack_1 : boolean;
  signal binary_1051_inst_req_0 : boolean;
  signal binary_1051_inst_ack_0 : boolean;
  signal phi_stmt_915_req_0 : boolean;
  signal binary_1011_inst_ack_0 : boolean;
  signal binary_1039_inst_ack_0 : boolean;
  signal type_cast_925_inst_req_0 : boolean;
  signal simple_obj_ref_625_load_0_req_0 : boolean;
  signal simple_obj_ref_625_load_0_ack_0 : boolean;
  signal simple_obj_ref_625_load_0_req_1 : boolean;
  signal simple_obj_ref_625_load_0_ack_1 : boolean;
  signal simple_obj_ref_625_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_625_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_628_load_0_req_0 : boolean;
  signal simple_obj_ref_628_load_0_ack_0 : boolean;
  signal simple_obj_ref_628_load_0_req_1 : boolean;
  signal simple_obj_ref_628_load_0_ack_1 : boolean;
  signal simple_obj_ref_628_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_628_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_631_load_0_req_0 : boolean;
  signal simple_obj_ref_631_load_0_ack_0 : boolean;
  signal simple_obj_ref_631_load_0_req_1 : boolean;
  signal simple_obj_ref_631_load_0_ack_1 : boolean;
  signal simple_obj_ref_631_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_631_gather_scatter_ack_0 : boolean;
  signal binary_665_inst_req_0 : boolean;
  signal binary_665_inst_ack_0 : boolean;
  signal binary_665_inst_req_1 : boolean;
  signal binary_665_inst_ack_1 : boolean;
  signal array_obj_ref_669_index_0_resize_req_0 : boolean;
  signal array_obj_ref_669_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_669_index_0_rename_req_0 : boolean;
  signal array_obj_ref_669_index_0_rename_ack_0 : boolean;
  signal array_obj_ref_669_offset_inst_req_0 : boolean;
  signal array_obj_ref_669_offset_inst_ack_0 : boolean;
  signal array_obj_ref_669_root_address_inst_req_0 : boolean;
  signal array_obj_ref_669_root_address_inst_ack_0 : boolean;
  signal addr_of_670_final_reg_req_0 : boolean;
  signal addr_of_670_final_reg_ack_0 : boolean;
  signal ptr_deref_674_base_resize_req_0 : boolean;
  signal ptr_deref_674_base_resize_ack_0 : boolean;
  signal simple_obj_ref_905_gather_scatter_ack_0 : boolean;
  signal ptr_deref_674_root_address_inst_req_0 : boolean;
  signal ptr_deref_674_root_address_inst_ack_0 : boolean;
  signal simple_obj_ref_905_gather_scatter_req_0 : boolean;
  signal ptr_deref_674_addr_0_req_0 : boolean;
  signal ptr_deref_674_addr_0_ack_0 : boolean;
  signal ptr_deref_674_load_0_req_0 : boolean;
  signal ptr_deref_674_load_0_ack_0 : boolean;
  signal ptr_deref_674_load_0_req_1 : boolean;
  signal ptr_deref_674_load_0_ack_1 : boolean;
  signal ptr_deref_674_gather_scatter_req_0 : boolean;
  signal ptr_deref_674_gather_scatter_ack_0 : boolean;
  signal binary_680_inst_req_0 : boolean;
  signal binary_680_inst_ack_0 : boolean;
  signal binary_680_inst_req_1 : boolean;
  signal binary_680_inst_ack_1 : boolean;
  signal binary_685_inst_req_0 : boolean;
  signal binary_685_inst_ack_0 : boolean;
  signal binary_685_inst_req_1 : boolean;
  signal binary_685_inst_ack_1 : boolean;
  signal binary_691_inst_req_0 : boolean;
  signal binary_691_inst_ack_0 : boolean;
  signal binary_691_inst_req_1 : boolean;
  signal binary_691_inst_ack_1 : boolean;
  signal binary_696_inst_req_0 : boolean;
  signal binary_696_inst_ack_0 : boolean;
  signal binary_696_inst_req_1 : boolean;
  signal binary_696_inst_ack_1 : boolean;
  signal binary_1016_inst_ack_0 : boolean;
  signal binary_763_inst_req_0 : boolean;
  signal binary_763_inst_ack_0 : boolean;
  signal binary_763_inst_req_1 : boolean;
  signal binary_870_inst_req_0 : boolean;
  signal binary_763_inst_ack_1 : boolean;
  signal binary_1022_inst_ack_1 : boolean;
  signal simple_obj_ref_908_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_908_gather_scatter_req_0 : boolean;
  signal binary_1016_inst_req_0 : boolean;
  signal simple_obj_ref_908_load_0_ack_1 : boolean;
  signal simple_obj_ref_895_store_0_ack_0 : boolean;
  signal simple_obj_ref_908_load_0_req_1 : boolean;
  signal simple_obj_ref_895_store_0_req_0 : boolean;
  signal binary_768_inst_req_0 : boolean;
  signal binary_768_inst_ack_0 : boolean;
  signal binary_768_inst_req_1 : boolean;
  signal binary_768_inst_ack_1 : boolean;
  signal binary_1022_inst_req_1 : boolean;
  signal binary_774_inst_req_0 : boolean;
  signal binary_774_inst_ack_0 : boolean;
  signal binary_774_inst_req_1 : boolean;
  signal binary_774_inst_ack_1 : boolean;
  signal binary_1022_inst_ack_0 : boolean;
  signal simple_obj_ref_908_load_0_ack_0 : boolean;
  signal simple_obj_ref_908_load_0_req_0 : boolean;
  signal binary_965_inst_ack_1 : boolean;
  signal simple_obj_ref_895_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_895_gather_scatter_req_0 : boolean;
  signal phi_stmt_928_req_0 : boolean;
  signal binary_780_inst_req_0 : boolean;
  signal binary_965_inst_ack_0 : boolean;
  signal binary_780_inst_ack_0 : boolean;
  signal binary_965_inst_req_1 : boolean;
  signal binary_780_inst_req_1 : boolean;
  signal binary_780_inst_ack_1 : boolean;
  signal binary_786_inst_req_0 : boolean;
  signal binary_786_inst_ack_0 : boolean;
  signal binary_786_inst_req_1 : boolean;
  signal binary_786_inst_ack_1 : boolean;
  signal binary_792_inst_req_0 : boolean;
  signal binary_792_inst_ack_0 : boolean;
  signal binary_792_inst_req_1 : boolean;
  signal binary_792_inst_ack_1 : boolean;
  signal binary_797_inst_req_0 : boolean;
  signal binary_797_inst_ack_0 : boolean;
  signal binary_797_inst_req_1 : boolean;
  signal binary_797_inst_ack_1 : boolean;
  signal phi_stmt_654_ack_0 : boolean;
  signal binary_803_inst_req_0 : boolean;
  signal binary_803_inst_ack_0 : boolean;
  signal binary_803_inst_req_1 : boolean;
  signal binary_803_inst_ack_1 : boolean;
  signal type_cast_937_inst_req_0 : boolean;
  signal binary_808_inst_req_0 : boolean;
  signal binary_808_inst_ack_0 : boolean;
  signal binary_808_inst_req_1 : boolean;
  signal binary_808_inst_ack_1 : boolean;
  signal binary_814_inst_req_0 : boolean;
  signal binary_814_inst_ack_0 : boolean;
  signal binary_814_inst_req_1 : boolean;
  signal binary_814_inst_ack_1 : boolean;
  signal binary_820_inst_req_0 : boolean;
  signal binary_820_inst_ack_0 : boolean;
  signal binary_820_inst_req_1 : boolean;
  signal binary_820_inst_ack_1 : boolean;
  signal type_cast_937_inst_ack_0 : boolean;
  signal binary_826_inst_req_0 : boolean;
  signal binary_826_inst_ack_0 : boolean;
  signal binary_826_inst_req_1 : boolean;
  signal binary_826_inst_ack_1 : boolean;
  signal binary_832_inst_req_0 : boolean;
  signal binary_832_inst_ack_0 : boolean;
  signal binary_832_inst_req_1 : boolean;
  signal binary_832_inst_ack_1 : boolean;
  signal binary_838_inst_req_0 : boolean;
  signal binary_838_inst_ack_0 : boolean;
  signal binary_838_inst_req_1 : boolean;
  signal binary_838_inst_ack_1 : boolean;
  signal binary_844_inst_req_0 : boolean;
  signal binary_844_inst_ack_0 : boolean;
  signal binary_844_inst_req_1 : boolean;
  signal binary_844_inst_ack_1 : boolean;
  signal binary_849_inst_req_0 : boolean;
  signal binary_849_inst_ack_0 : boolean;
  signal binary_849_inst_req_1 : boolean;
  signal binary_849_inst_ack_1 : boolean;
  signal binary_854_inst_req_0 : boolean;
  signal binary_854_inst_ack_0 : boolean;
  signal binary_854_inst_req_1 : boolean;
  signal binary_854_inst_ack_1 : boolean;
  signal binary_859_inst_req_0 : boolean;
  signal binary_859_inst_ack_0 : boolean;
  signal binary_859_inst_req_1 : boolean;
  signal binary_859_inst_ack_1 : boolean;
  signal binary_865_inst_req_0 : boolean;
  signal binary_865_inst_ack_0 : boolean;
  signal binary_865_inst_req_1 : boolean;
  signal binary_865_inst_ack_1 : boolean;
  signal binary_1056_inst_req_0 : boolean;
  signal binary_1056_inst_ack_0 : boolean;
  signal binary_1056_inst_req_1 : boolean;
  signal binary_1056_inst_ack_1 : boolean;
  signal binary_1062_inst_req_0 : boolean;
  signal binary_1062_inst_ack_0 : boolean;
  signal binary_1062_inst_req_1 : boolean;
  signal binary_1062_inst_ack_1 : boolean;
  signal phi_stmt_934_req_1 : boolean;
  signal type_cast_939_inst_ack_0 : boolean;
  signal binary_1067_inst_req_0 : boolean;
  signal binary_1067_inst_ack_0 : boolean;
  signal binary_1067_inst_req_1 : boolean;
  signal binary_1067_inst_ack_1 : boolean;
  signal type_cast_939_inst_req_0 : boolean;
  signal binary_1073_inst_req_0 : boolean;
  signal binary_1073_inst_ack_0 : boolean;
  signal binary_1073_inst_req_1 : boolean;
  signal binary_1073_inst_ack_1 : boolean;
  signal binary_1079_inst_req_0 : boolean;
  signal binary_1079_inst_ack_0 : boolean;
  signal binary_1079_inst_req_1 : boolean;
  signal binary_1079_inst_ack_1 : boolean;
  signal binary_1085_inst_req_0 : boolean;
  signal binary_1085_inst_ack_0 : boolean;
  signal binary_1085_inst_req_1 : boolean;
  signal phi_stmt_635_req_0 : boolean;
  signal binary_1085_inst_ack_1 : boolean;
  signal phi_stmt_928_req_1 : boolean;
  signal binary_1091_inst_req_0 : boolean;
  signal binary_1091_inst_ack_0 : boolean;
  signal binary_1091_inst_req_1 : boolean;
  signal binary_1091_inst_ack_1 : boolean;
  signal type_cast_933_inst_ack_0 : boolean;
  signal type_cast_933_inst_req_0 : boolean;
  signal binary_1097_inst_req_0 : boolean;
  signal binary_1097_inst_ack_0 : boolean;
  signal binary_1097_inst_req_1 : boolean;
  signal binary_1097_inst_ack_1 : boolean;
  signal binary_1103_inst_req_0 : boolean;
  signal binary_1103_inst_ack_0 : boolean;
  signal binary_1103_inst_req_1 : boolean;
  signal binary_1103_inst_ack_1 : boolean;
  signal binary_1108_inst_req_0 : boolean;
  signal binary_1108_inst_ack_0 : boolean;
  signal phi_stmt_1161_ack_0 : boolean;
  signal binary_1108_inst_req_1 : boolean;
  signal binary_1108_inst_ack_1 : boolean;
  signal phi_stmt_1161_req_0 : boolean;
  signal phi_stmt_922_req_1 : boolean;
  signal type_cast_927_inst_ack_0 : boolean;
  signal binary_1113_inst_req_0 : boolean;
  signal binary_1113_inst_ack_0 : boolean;
  signal binary_1113_inst_req_1 : boolean;
  signal binary_1113_inst_ack_1 : boolean;
  signal type_cast_927_inst_req_0 : boolean;
  signal binary_1118_inst_req_0 : boolean;
  signal binary_1118_inst_ack_0 : boolean;
  signal binary_1118_inst_req_1 : boolean;
  signal binary_1118_inst_ack_1 : boolean;
  signal phi_stmt_1161_req_1 : boolean;
  signal binary_1124_inst_req_0 : boolean;
  signal binary_1124_inst_ack_0 : boolean;
  signal type_cast_1167_inst_ack_0 : boolean;
  signal binary_1124_inst_req_1 : boolean;
  signal binary_1124_inst_ack_1 : boolean;
  signal type_cast_1167_inst_req_0 : boolean;
  signal binary_1129_inst_req_0 : boolean;
  signal binary_1129_inst_ack_0 : boolean;
  signal binary_1129_inst_req_1 : boolean;
  signal binary_1129_inst_ack_1 : boolean;
  signal phi_stmt_915_req_1 : boolean;
  signal type_cast_921_inst_ack_0 : boolean;
  signal type_cast_921_inst_req_0 : boolean;
  signal binary_1135_inst_req_0 : boolean;
  signal binary_1135_inst_ack_0 : boolean;
  signal binary_1135_inst_req_1 : boolean;
  signal binary_1135_inst_ack_1 : boolean;
  signal binary_1141_inst_req_0 : boolean;
  signal binary_1141_inst_ack_0 : boolean;
  signal binary_1141_inst_req_1 : boolean;
  signal binary_1141_inst_ack_1 : boolean;
  signal if_stmt_1143_branch_req_0 : boolean;
  signal if_stmt_1143_branch_ack_1 : boolean;
  signal if_stmt_1143_branch_ack_0 : boolean;
  signal simple_obj_ref_1150_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_1150_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_1150_store_0_req_0 : boolean;
  signal simple_obj_ref_1150_store_0_ack_0 : boolean;
  signal simple_obj_ref_1150_store_0_req_1 : boolean;
  signal simple_obj_ref_1150_store_0_ack_1 : boolean;
  signal simple_obj_ref_1153_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_1153_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_1153_store_0_req_0 : boolean;
  signal simple_obj_ref_1153_store_0_ack_0 : boolean;
  signal simple_obj_ref_1153_store_0_req_1 : boolean;
  signal simple_obj_ref_1153_store_0_ack_1 : boolean;
  signal simple_obj_ref_1156_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_1156_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_1156_store_0_req_0 : boolean;
  signal simple_obj_ref_1156_store_0_ack_0 : boolean;
  signal simple_obj_ref_1156_store_0_req_1 : boolean;
  signal simple_obj_ref_1156_store_0_ack_1 : boolean;
  signal call_stmt_1170_call_req_0 : boolean;
  signal call_stmt_1170_call_ack_0 : boolean;
  signal call_stmt_1170_call_req_1 : boolean;
  signal call_stmt_1170_call_ack_1 : boolean;
  signal binary_1175_inst_req_0 : boolean;
  signal binary_1175_inst_ack_0 : boolean;
  signal binary_1175_inst_req_1 : boolean;
  signal binary_1175_inst_ack_1 : boolean;
  signal binary_1181_inst_req_0 : boolean;
  signal binary_1181_inst_ack_0 : boolean;
  signal binary_1181_inst_req_1 : boolean;
  signal binary_1181_inst_ack_1 : boolean;
  signal if_stmt_1183_branch_req_0 : boolean;
  signal if_stmt_1183_branch_ack_1 : boolean;
  signal if_stmt_1183_branch_ack_0 : boolean;
  signal type_cast_641_inst_req_0 : boolean;
  signal type_cast_641_inst_ack_0 : boolean;
  signal phi_stmt_635_req_1 : boolean;
  signal type_cast_647_inst_req_0 : boolean;
  signal type_cast_647_inst_ack_0 : boolean;
  signal phi_stmt_642_req_1 : boolean;
  signal type_cast_653_inst_req_0 : boolean;
  signal type_cast_653_inst_ack_0 : boolean;
  signal phi_stmt_648_req_1 : boolean;
  signal type_cast_659_inst_req_0 : boolean;
  signal type_cast_659_inst_ack_0 : boolean;
  signal phi_stmt_654_req_1 : boolean;
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
  a5init_CP_1104: Block -- control-path 
    signal cp_elements: BooleanArray(582 downto 0);
    -- 
  begin -- 
    cp_elements(0) <= start_req_symbol;
    start_ack_symbol <= cp_elements(10);
    finAckJoin: join2 port map(pred0 => fin_req_symbol, pred1 => cp_elements(10), symbol_out => fin_ack_symbol, clk => clk, reset => reset);
    cp_elements(1) <= cp_elements(24);
    cp_elements(2) <= cp_elements(528);
    cp_elements(3) <= cp_elements(215);
    cp_elements(4) <= OrReduce(cp_elements(222) & cp_elements(530));
    cp_elements(5) <= cp_elements(266);
    cp_elements(6) <= cp_elements(574);
    cp_elements(7) <= cp_elements(434);
    cp_elements(8) <= OrReduce(cp_elements(441) & cp_elements(576));
    cp_elements(9) <= cp_elements(463);
    phi_stmt_1161_req_0 <= cp_elements(9);
    cp_elements(10) <= OrReduce(cp_elements(482) & cp_elements(582));
    cp_elements(11) <= cp_elements(0);
    cp_elements(12) <= cp_elements(11);
    simple_obj_ref_625_load_0_req_0 <= cp_elements(12);
    cp_elements(13) <= simple_obj_ref_625_load_0_ack_0;
    simple_obj_ref_625_load_0_req_1 <= cp_elements(13);
    cp_elements(14) <= simple_obj_ref_625_load_0_ack_1;
    simple_obj_ref_625_gather_scatter_req_0 <= cp_elements(14);
    cp_elements(15) <= simple_obj_ref_625_gather_scatter_ack_0;
    cp_elements(16) <= cp_elements(11);
    simple_obj_ref_628_load_0_req_0 <= cp_elements(16);
    cp_elements(17) <= simple_obj_ref_628_load_0_ack_0;
    simple_obj_ref_628_load_0_req_1 <= cp_elements(17);
    cp_elements(18) <= simple_obj_ref_628_load_0_ack_1;
    simple_obj_ref_628_gather_scatter_req_0 <= cp_elements(18);
    cp_elements(19) <= simple_obj_ref_628_gather_scatter_ack_0;
    cp_elements(20) <= cp_elements(11);
    simple_obj_ref_631_load_0_req_0 <= cp_elements(20);
    cp_elements(21) <= simple_obj_ref_631_load_0_ack_0;
    simple_obj_ref_631_load_0_req_1 <= cp_elements(21);
    cp_elements(22) <= simple_obj_ref_631_load_0_ack_1;
    simple_obj_ref_631_gather_scatter_req_0 <= cp_elements(22);
    cp_elements(23) <= simple_obj_ref_631_gather_scatter_ack_0;
    cpelement_group_24 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(19) & cp_elements(23) & cp_elements(15));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(24),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(25) <= cp_elements(2);
    cpelement_group_26 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(27) & cp_elements(28));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(26),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_665_inst_req_0 <= cp_elements(26);
    cp_elements(27) <= cp_elements(25);
    cp_elements(28) <= cp_elements(25);
    cp_elements(29) <= binary_665_inst_ack_0;
    binary_665_inst_req_1 <= cp_elements(29);
    cp_elements(30) <= binary_665_inst_ack_1;
    array_obj_ref_669_index_0_resize_req_0 <= cp_elements(30);
    cpelement_group_31 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(32) & cp_elements(36));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(31),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    addr_of_670_final_reg_req_0 <= cp_elements(31);
    cp_elements(32) <= cp_elements(25);
    cp_elements(33) <= array_obj_ref_669_index_0_resize_ack_0;
    array_obj_ref_669_index_0_rename_req_0 <= cp_elements(33);
    cp_elements(34) <= array_obj_ref_669_index_0_rename_ack_0;
    array_obj_ref_669_offset_inst_req_0 <= cp_elements(34);
    cp_elements(35) <= array_obj_ref_669_offset_inst_ack_0;
    array_obj_ref_669_root_address_inst_req_0 <= cp_elements(35);
    cp_elements(36) <= array_obj_ref_669_root_address_inst_ack_0;
    cp_elements(37) <= addr_of_670_final_reg_ack_0;
    cpelement_group_38 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(42) & cp_elements(37));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(38),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    ptr_deref_674_load_0_req_0 <= cp_elements(38);
    cp_elements(39) <= cp_elements(37);
    ptr_deref_674_base_resize_req_0 <= cp_elements(39);
    cp_elements(40) <= ptr_deref_674_base_resize_ack_0;
    ptr_deref_674_root_address_inst_req_0 <= cp_elements(40);
    cp_elements(41) <= ptr_deref_674_root_address_inst_ack_0;
    ptr_deref_674_addr_0_req_0 <= cp_elements(41);
    cp_elements(42) <= ptr_deref_674_addr_0_ack_0;
    cp_elements(43) <= ptr_deref_674_load_0_ack_0;
    ptr_deref_674_load_0_req_1 <= cp_elements(43);
    cp_elements(44) <= ptr_deref_674_load_0_ack_1;
    ptr_deref_674_gather_scatter_req_0 <= cp_elements(44);
    cp_elements(45) <= ptr_deref_674_gather_scatter_ack_0;
    cpelement_group_46 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(47) & cp_elements(48));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(46),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_680_inst_req_0 <= cp_elements(46);
    cp_elements(47) <= cp_elements(25);
    cp_elements(48) <= cp_elements(25);
    cp_elements(49) <= binary_680_inst_ack_0;
    binary_680_inst_req_1 <= cp_elements(49);
    cp_elements(50) <= binary_680_inst_ack_1;
    cpelement_group_51 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(45) & cp_elements(50) & cp_elements(52));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(51),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_685_inst_req_0 <= cp_elements(51);
    cp_elements(52) <= cp_elements(25);
    cp_elements(53) <= binary_685_inst_ack_0;
    binary_685_inst_req_1 <= cp_elements(53);
    cp_elements(54) <= binary_685_inst_ack_1;
    cpelement_group_55 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(54) & cp_elements(56));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(55),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_691_inst_req_0 <= cp_elements(55);
    cp_elements(56) <= cp_elements(25);
    cp_elements(57) <= binary_691_inst_ack_0;
    binary_691_inst_req_1 <= cp_elements(57);
    cp_elements(58) <= binary_691_inst_ack_1;
    cpelement_group_59 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(60) & cp_elements(61) & cp_elements(62));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(59),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_696_inst_req_0 <= cp_elements(59);
    cp_elements(60) <= cp_elements(25);
    cp_elements(61) <= cp_elements(58);
    cp_elements(62) <= cp_elements(25);
    cp_elements(63) <= binary_696_inst_ack_0;
    binary_696_inst_req_1 <= cp_elements(63);
    cp_elements(64) <= binary_696_inst_ack_1;
    cpelement_group_65 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(66) & cp_elements(67) & cp_elements(68));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(65),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_701_inst_req_0 <= cp_elements(65);
    cp_elements(66) <= cp_elements(25);
    cp_elements(67) <= cp_elements(25);
    cp_elements(68) <= cp_elements(58);
    cp_elements(69) <= binary_701_inst_ack_0;
    binary_701_inst_req_1 <= cp_elements(69);
    cp_elements(70) <= binary_701_inst_ack_1;
    cpelement_group_71 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(72) & cp_elements(73) & cp_elements(74));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(71),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_706_inst_req_0 <= cp_elements(71);
    cp_elements(72) <= cp_elements(25);
    cp_elements(73) <= cp_elements(25);
    cp_elements(74) <= cp_elements(58);
    cp_elements(75) <= binary_706_inst_ack_0;
    binary_706_inst_req_1 <= cp_elements(75);
    cp_elements(76) <= binary_706_inst_ack_1;
    cpelement_group_77 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(78) & cp_elements(79));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(77),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_712_inst_req_0 <= cp_elements(77);
    cp_elements(78) <= cp_elements(25);
    cp_elements(79) <= cp_elements(64);
    cp_elements(80) <= binary_712_inst_ack_0;
    binary_712_inst_req_1 <= cp_elements(80);
    cp_elements(81) <= binary_712_inst_ack_1;
    cpelement_group_82 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(83) & cp_elements(84));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(82),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_718_inst_req_0 <= cp_elements(82);
    cp_elements(83) <= cp_elements(25);
    cp_elements(84) <= cp_elements(64);
    cp_elements(85) <= binary_718_inst_ack_0;
    binary_718_inst_req_1 <= cp_elements(85);
    cp_elements(86) <= binary_718_inst_ack_1;
    cpelement_group_87 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(88) & cp_elements(89));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(87),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_724_inst_req_0 <= cp_elements(87);
    cp_elements(88) <= cp_elements(25);
    cp_elements(89) <= cp_elements(64);
    cp_elements(90) <= binary_724_inst_ack_0;
    binary_724_inst_req_1 <= cp_elements(90);
    cp_elements(91) <= binary_724_inst_ack_1;
    cpelement_group_92 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(93) & cp_elements(94));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(92),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_730_inst_req_0 <= cp_elements(92);
    cp_elements(93) <= cp_elements(25);
    cp_elements(94) <= cp_elements(64);
    cp_elements(95) <= binary_730_inst_ack_0;
    binary_730_inst_req_1 <= cp_elements(95);
    cp_elements(96) <= binary_730_inst_ack_1;
    cpelement_group_97 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(98) & cp_elements(99));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(97),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_736_inst_req_0 <= cp_elements(97);
    cp_elements(98) <= cp_elements(25);
    cp_elements(99) <= cp_elements(64);
    cp_elements(100) <= binary_736_inst_ack_0;
    binary_736_inst_req_1 <= cp_elements(100);
    cp_elements(101) <= binary_736_inst_ack_1;
    cpelement_group_102 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(101) & cp_elements(103));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(102),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_742_inst_req_0 <= cp_elements(102);
    cp_elements(103) <= cp_elements(25);
    cp_elements(104) <= binary_742_inst_ack_0;
    binary_742_inst_req_1 <= cp_elements(104);
    cp_elements(105) <= binary_742_inst_ack_1;
    cpelement_group_106 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(81) & cp_elements(86) & cp_elements(107));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(106),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_747_inst_req_0 <= cp_elements(106);
    cp_elements(107) <= cp_elements(25);
    cp_elements(108) <= binary_747_inst_ack_0;
    binary_747_inst_req_1 <= cp_elements(108);
    cp_elements(109) <= binary_747_inst_ack_1;
    cpelement_group_110 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(96) & cp_elements(109) & cp_elements(111));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(110),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_752_inst_req_0 <= cp_elements(110);
    cp_elements(111) <= cp_elements(25);
    cp_elements(112) <= binary_752_inst_ack_0;
    binary_752_inst_req_1 <= cp_elements(112);
    cp_elements(113) <= binary_752_inst_ack_1;
    cpelement_group_114 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(91) & cp_elements(113) & cp_elements(115));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(114),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_757_inst_req_0 <= cp_elements(114);
    cp_elements(115) <= cp_elements(25);
    cp_elements(116) <= binary_757_inst_ack_0;
    binary_757_inst_req_1 <= cp_elements(116);
    cp_elements(117) <= binary_757_inst_ack_1;
    cpelement_group_118 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(117) & cp_elements(119));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(118),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_763_inst_req_0 <= cp_elements(118);
    cp_elements(119) <= cp_elements(25);
    cp_elements(120) <= binary_763_inst_ack_0;
    binary_763_inst_req_1 <= cp_elements(120);
    cp_elements(121) <= binary_763_inst_ack_1;
    cpelement_group_122 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(105) & cp_elements(121) & cp_elements(123));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(122),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_768_inst_req_0 <= cp_elements(122);
    cp_elements(123) <= cp_elements(25);
    cp_elements(124) <= binary_768_inst_ack_0;
    binary_768_inst_req_1 <= cp_elements(124);
    cp_elements(125) <= binary_768_inst_ack_1;
    cpelement_group_126 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(127) & cp_elements(128));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(126),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_774_inst_req_0 <= cp_elements(126);
    cp_elements(127) <= cp_elements(25);
    cp_elements(128) <= cp_elements(70);
    cp_elements(129) <= binary_774_inst_ack_0;
    binary_774_inst_req_1 <= cp_elements(129);
    cp_elements(130) <= binary_774_inst_ack_1;
    cpelement_group_131 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(132) & cp_elements(133));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(131),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_780_inst_req_0 <= cp_elements(131);
    cp_elements(132) <= cp_elements(25);
    cp_elements(133) <= cp_elements(70);
    cp_elements(134) <= binary_780_inst_ack_0;
    binary_780_inst_req_1 <= cp_elements(134);
    cp_elements(135) <= binary_780_inst_ack_1;
    cpelement_group_136 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(137) & cp_elements(138));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(136),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_786_inst_req_0 <= cp_elements(136);
    cp_elements(137) <= cp_elements(25);
    cp_elements(138) <= cp_elements(70);
    cp_elements(139) <= binary_786_inst_ack_0;
    binary_786_inst_req_1 <= cp_elements(139);
    cp_elements(140) <= binary_786_inst_ack_1;
    cpelement_group_141 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(140) & cp_elements(142));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(141),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_792_inst_req_0 <= cp_elements(141);
    cp_elements(142) <= cp_elements(25);
    cp_elements(143) <= binary_792_inst_ack_0;
    binary_792_inst_req_1 <= cp_elements(143);
    cp_elements(144) <= binary_792_inst_ack_1;
    cpelement_group_145 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(130) & cp_elements(135) & cp_elements(146));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(145),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_797_inst_req_0 <= cp_elements(145);
    cp_elements(146) <= cp_elements(25);
    cp_elements(147) <= binary_797_inst_ack_0;
    binary_797_inst_req_1 <= cp_elements(147);
    cp_elements(148) <= binary_797_inst_ack_1;
    cpelement_group_149 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(148) & cp_elements(150));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(149),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_803_inst_req_0 <= cp_elements(149);
    cp_elements(150) <= cp_elements(25);
    cp_elements(151) <= binary_803_inst_ack_0;
    binary_803_inst_req_1 <= cp_elements(151);
    cp_elements(152) <= binary_803_inst_ack_1;
    cpelement_group_153 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(144) & cp_elements(152) & cp_elements(154));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(153),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_808_inst_req_0 <= cp_elements(153);
    cp_elements(154) <= cp_elements(25);
    cp_elements(155) <= binary_808_inst_ack_0;
    binary_808_inst_req_1 <= cp_elements(155);
    cp_elements(156) <= binary_808_inst_ack_1;
    cpelement_group_157 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(158) & cp_elements(159));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(157),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_814_inst_req_0 <= cp_elements(157);
    cp_elements(158) <= cp_elements(25);
    cp_elements(159) <= cp_elements(76);
    cp_elements(160) <= binary_814_inst_ack_0;
    binary_814_inst_req_1 <= cp_elements(160);
    cp_elements(161) <= binary_814_inst_ack_1;
    cpelement_group_162 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(163) & cp_elements(164));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(162),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_820_inst_req_0 <= cp_elements(162);
    cp_elements(163) <= cp_elements(25);
    cp_elements(164) <= cp_elements(76);
    cp_elements(165) <= binary_820_inst_ack_0;
    binary_820_inst_req_1 <= cp_elements(165);
    cp_elements(166) <= binary_820_inst_ack_1;
    cpelement_group_167 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(168) & cp_elements(169));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(167),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_826_inst_req_0 <= cp_elements(167);
    cp_elements(168) <= cp_elements(25);
    cp_elements(169) <= cp_elements(76);
    cp_elements(170) <= binary_826_inst_ack_0;
    binary_826_inst_req_1 <= cp_elements(170);
    cp_elements(171) <= binary_826_inst_ack_1;
    cpelement_group_172 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(173) & cp_elements(174));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(172),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_832_inst_req_0 <= cp_elements(172);
    cp_elements(173) <= cp_elements(25);
    cp_elements(174) <= cp_elements(76);
    cp_elements(175) <= binary_832_inst_ack_0;
    binary_832_inst_req_1 <= cp_elements(175);
    cp_elements(176) <= binary_832_inst_ack_1;
    cpelement_group_177 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(178) & cp_elements(179));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(177),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_838_inst_req_0 <= cp_elements(177);
    cp_elements(178) <= cp_elements(25);
    cp_elements(179) <= cp_elements(76);
    cp_elements(180) <= binary_838_inst_ack_0;
    binary_838_inst_req_1 <= cp_elements(180);
    cp_elements(181) <= binary_838_inst_ack_1;
    cpelement_group_182 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(181) & cp_elements(183));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(182),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_844_inst_req_0 <= cp_elements(182);
    cp_elements(183) <= cp_elements(25);
    cp_elements(184) <= binary_844_inst_ack_0;
    binary_844_inst_req_1 <= cp_elements(184);
    cp_elements(185) <= binary_844_inst_ack_1;
    cpelement_group_186 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(161) & cp_elements(166) & cp_elements(187));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(186),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_849_inst_req_0 <= cp_elements(186);
    cp_elements(187) <= cp_elements(25);
    cp_elements(188) <= binary_849_inst_ack_0;
    binary_849_inst_req_1 <= cp_elements(188);
    cp_elements(189) <= binary_849_inst_ack_1;
    cpelement_group_190 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(176) & cp_elements(189) & cp_elements(191));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(190),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_854_inst_req_0 <= cp_elements(190);
    cp_elements(191) <= cp_elements(25);
    cp_elements(192) <= binary_854_inst_ack_0;
    binary_854_inst_req_1 <= cp_elements(192);
    cp_elements(193) <= binary_854_inst_ack_1;
    cpelement_group_194 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(171) & cp_elements(193) & cp_elements(195));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(194),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_859_inst_req_0 <= cp_elements(194);
    cp_elements(195) <= cp_elements(25);
    cp_elements(196) <= binary_859_inst_ack_0;
    binary_859_inst_req_1 <= cp_elements(196);
    cp_elements(197) <= binary_859_inst_ack_1;
    cpelement_group_198 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(197) & cp_elements(199));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(198),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_865_inst_req_0 <= cp_elements(198);
    cp_elements(199) <= cp_elements(25);
    cp_elements(200) <= binary_865_inst_ack_0;
    binary_865_inst_req_1 <= cp_elements(200);
    cp_elements(201) <= binary_865_inst_ack_1;
    cpelement_group_202 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(185) & cp_elements(201) & cp_elements(203));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(202),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_870_inst_req_0 <= cp_elements(202);
    cp_elements(203) <= cp_elements(25);
    cp_elements(204) <= binary_870_inst_ack_0;
    binary_870_inst_req_1 <= cp_elements(204);
    cp_elements(205) <= binary_870_inst_ack_1;
    cpelement_group_206 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(207) & cp_elements(208));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(206),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_876_inst_req_0 <= cp_elements(206);
    cp_elements(207) <= cp_elements(25);
    cp_elements(208) <= cp_elements(25);
    cp_elements(209) <= binary_876_inst_ack_0;
    binary_876_inst_req_1 <= cp_elements(209);
    cp_elements(210) <= binary_876_inst_ack_1;
    cpelement_group_211 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(210) & cp_elements(212));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(211),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_882_inst_req_0 <= cp_elements(211);
    cp_elements(212) <= cp_elements(25);
    cp_elements(213) <= binary_882_inst_ack_0;
    binary_882_inst_req_1 <= cp_elements(213);
    cp_elements(214) <= binary_882_inst_ack_1;
    cpelement_group_215 : Block -- 
      signal predecessors: BooleanArray(3 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(125) & cp_elements(156) & cp_elements(205) & cp_elements(214));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(215),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(216) <= cp_elements(3);
    cp_elements(217) <= false;
    cp_elements(218) <= cp_elements(217);
    cp_elements(219) <= cp_elements(3);
    if_stmt_885_branch_req_0 <= cp_elements(219);
    cp_elements(220) <= cp_elements(219);
    cp_elements(221) <= cp_elements(220);
    cp_elements(222) <= if_stmt_885_branch_ack_1;
    cp_elements(223) <= cp_elements(220);
    cp_elements(224) <= if_stmt_885_branch_ack_0;
    cp_elements(225) <= cp_elements(4);
    cp_elements(226) <= cp_elements(225);
    cpelement_group_227 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(226) & cp_elements(228));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(227),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_892_gather_scatter_req_0 <= cp_elements(227);
    cp_elements(228) <= cp_elements(225);
    cp_elements(229) <= simple_obj_ref_892_gather_scatter_ack_0;
    simple_obj_ref_892_store_0_req_0 <= cp_elements(229);
    cp_elements(230) <= simple_obj_ref_892_store_0_ack_0;
    cp_elements(231) <= cp_elements(230);
    simple_obj_ref_892_store_0_req_1 <= cp_elements(231);
    cp_elements(232) <= simple_obj_ref_892_store_0_ack_1;
    cp_elements(233) <= cp_elements(225);
    cpelement_group_234 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(233) & cp_elements(235));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(234),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_895_gather_scatter_req_0 <= cp_elements(234);
    cp_elements(235) <= cp_elements(225);
    cp_elements(236) <= simple_obj_ref_895_gather_scatter_ack_0;
    simple_obj_ref_895_store_0_req_0 <= cp_elements(236);
    cp_elements(237) <= simple_obj_ref_895_store_0_ack_0;
    cp_elements(238) <= cp_elements(237);
    simple_obj_ref_895_store_0_req_1 <= cp_elements(238);
    cp_elements(239) <= simple_obj_ref_895_store_0_ack_1;
    cp_elements(240) <= cp_elements(225);
    cpelement_group_241 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(240) & cp_elements(242));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(241),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_898_gather_scatter_req_0 <= cp_elements(241);
    cp_elements(242) <= cp_elements(225);
    cp_elements(243) <= simple_obj_ref_898_gather_scatter_ack_0;
    simple_obj_ref_898_store_0_req_0 <= cp_elements(243);
    cp_elements(244) <= simple_obj_ref_898_store_0_ack_0;
    cp_elements(245) <= cp_elements(244);
    simple_obj_ref_898_store_0_req_1 <= cp_elements(245);
    cp_elements(246) <= simple_obj_ref_898_store_0_ack_1;
    cp_elements(247) <= cp_elements(225);
    simple_obj_ref_902_load_0_req_0 <= cp_elements(247);
    cp_elements(248) <= simple_obj_ref_902_load_0_ack_0;
    simple_obj_ref_902_load_0_req_1 <= cp_elements(248);
    cp_elements(249) <= simple_obj_ref_902_load_0_ack_1;
    simple_obj_ref_902_gather_scatter_req_0 <= cp_elements(249);
    cp_elements(250) <= simple_obj_ref_902_gather_scatter_ack_0;
    cpelement_group_251 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(244) & cp_elements(252));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(251),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_905_load_0_req_0 <= cp_elements(251);
    cp_elements(252) <= cp_elements(225);
    cp_elements(253) <= simple_obj_ref_905_load_0_ack_0;
    simple_obj_ref_905_load_0_req_1 <= cp_elements(253);
    cp_elements(254) <= simple_obj_ref_905_load_0_ack_1;
    simple_obj_ref_905_gather_scatter_req_0 <= cp_elements(254);
    cp_elements(255) <= simple_obj_ref_905_gather_scatter_ack_0;
    cpelement_group_256 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(237) & cp_elements(257));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(256),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_908_load_0_req_0 <= cp_elements(256);
    cp_elements(257) <= cp_elements(225);
    cp_elements(258) <= simple_obj_ref_908_load_0_ack_0;
    simple_obj_ref_908_load_0_req_1 <= cp_elements(258);
    cp_elements(259) <= simple_obj_ref_908_load_0_ack_1;
    simple_obj_ref_908_gather_scatter_req_0 <= cp_elements(259);
    cp_elements(260) <= simple_obj_ref_908_gather_scatter_ack_0;
    cpelement_group_261 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(230) & cp_elements(262));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(261),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_911_load_0_req_0 <= cp_elements(261);
    cp_elements(262) <= cp_elements(225);
    cp_elements(263) <= simple_obj_ref_911_load_0_ack_0;
    simple_obj_ref_911_load_0_req_1 <= cp_elements(263);
    cp_elements(264) <= simple_obj_ref_911_load_0_ack_1;
    simple_obj_ref_911_gather_scatter_req_0 <= cp_elements(264);
    cp_elements(265) <= simple_obj_ref_911_gather_scatter_ack_0;
    cpelement_group_266 : Block -- 
      signal predecessors: BooleanArray(6 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(232) & cp_elements(239) & cp_elements(246) & cp_elements(250) & cp_elements(255) & cp_elements(260) & cp_elements(265));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(266),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(267) <= cp_elements(6);
    cpelement_group_268 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(269) & cp_elements(270) & cp_elements(271));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(268),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_944_inst_req_0 <= cp_elements(268);
    cp_elements(269) <= cp_elements(267);
    cp_elements(270) <= cp_elements(267);
    cp_elements(271) <= cp_elements(267);
    cp_elements(272) <= binary_944_inst_ack_0;
    binary_944_inst_req_1 <= cp_elements(272);
    cp_elements(273) <= binary_944_inst_ack_1;
    cpelement_group_274 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(273) & cp_elements(275));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(274),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_950_inst_req_0 <= cp_elements(274);
    cp_elements(275) <= cp_elements(267);
    cp_elements(276) <= binary_950_inst_ack_0;
    binary_950_inst_req_1 <= cp_elements(276);
    cp_elements(277) <= binary_950_inst_ack_1;
    cpelement_group_278 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(279) & cp_elements(280) & cp_elements(281));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(278),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_955_inst_req_0 <= cp_elements(278);
    cp_elements(279) <= cp_elements(267);
    cp_elements(280) <= cp_elements(277);
    cp_elements(281) <= cp_elements(267);
    cp_elements(282) <= binary_955_inst_ack_0;
    binary_955_inst_req_1 <= cp_elements(282);
    cp_elements(283) <= binary_955_inst_ack_1;
    cpelement_group_284 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(285) & cp_elements(286) & cp_elements(287));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(284),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_960_inst_req_0 <= cp_elements(284);
    cp_elements(285) <= cp_elements(267);
    cp_elements(286) <= cp_elements(267);
    cp_elements(287) <= cp_elements(277);
    cp_elements(288) <= binary_960_inst_ack_0;
    binary_960_inst_req_1 <= cp_elements(288);
    cp_elements(289) <= binary_960_inst_ack_1;
    cpelement_group_290 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(291) & cp_elements(292) & cp_elements(293));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(290),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_965_inst_req_0 <= cp_elements(290);
    cp_elements(291) <= cp_elements(267);
    cp_elements(292) <= cp_elements(267);
    cp_elements(293) <= cp_elements(277);
    cp_elements(294) <= binary_965_inst_ack_0;
    binary_965_inst_req_1 <= cp_elements(294);
    cp_elements(295) <= binary_965_inst_ack_1;
    cpelement_group_296 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(297) & cp_elements(298));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(296),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_971_inst_req_0 <= cp_elements(296);
    cp_elements(297) <= cp_elements(267);
    cp_elements(298) <= cp_elements(283);
    cp_elements(299) <= binary_971_inst_ack_0;
    binary_971_inst_req_1 <= cp_elements(299);
    cp_elements(300) <= binary_971_inst_ack_1;
    cpelement_group_301 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(302) & cp_elements(303));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(301),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_977_inst_req_0 <= cp_elements(301);
    cp_elements(302) <= cp_elements(267);
    cp_elements(303) <= cp_elements(283);
    cp_elements(304) <= binary_977_inst_ack_0;
    binary_977_inst_req_1 <= cp_elements(304);
    cp_elements(305) <= binary_977_inst_ack_1;
    cpelement_group_306 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(307) & cp_elements(308));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(306),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_983_inst_req_0 <= cp_elements(306);
    cp_elements(307) <= cp_elements(267);
    cp_elements(308) <= cp_elements(283);
    cp_elements(309) <= binary_983_inst_ack_0;
    binary_983_inst_req_1 <= cp_elements(309);
    cp_elements(310) <= binary_983_inst_ack_1;
    cpelement_group_311 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(312) & cp_elements(313));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(311),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_989_inst_req_0 <= cp_elements(311);
    cp_elements(312) <= cp_elements(267);
    cp_elements(313) <= cp_elements(283);
    cp_elements(314) <= binary_989_inst_ack_0;
    binary_989_inst_req_1 <= cp_elements(314);
    cp_elements(315) <= binary_989_inst_ack_1;
    cpelement_group_316 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(317) & cp_elements(318));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(316),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_995_inst_req_0 <= cp_elements(316);
    cp_elements(317) <= cp_elements(267);
    cp_elements(318) <= cp_elements(283);
    cp_elements(319) <= binary_995_inst_ack_0;
    binary_995_inst_req_1 <= cp_elements(319);
    cp_elements(320) <= binary_995_inst_ack_1;
    cpelement_group_321 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(320) & cp_elements(322));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(321),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1001_inst_req_0 <= cp_elements(321);
    cp_elements(322) <= cp_elements(267);
    cp_elements(323) <= binary_1001_inst_ack_0;
    binary_1001_inst_req_1 <= cp_elements(323);
    cp_elements(324) <= binary_1001_inst_ack_1;
    cpelement_group_325 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(300) & cp_elements(305) & cp_elements(326));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(325),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1006_inst_req_0 <= cp_elements(325);
    cp_elements(326) <= cp_elements(267);
    cp_elements(327) <= binary_1006_inst_ack_0;
    binary_1006_inst_req_1 <= cp_elements(327);
    cp_elements(328) <= binary_1006_inst_ack_1;
    cpelement_group_329 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(315) & cp_elements(328) & cp_elements(330));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(329),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1011_inst_req_0 <= cp_elements(329);
    cp_elements(330) <= cp_elements(267);
    cp_elements(331) <= binary_1011_inst_ack_0;
    binary_1011_inst_req_1 <= cp_elements(331);
    cp_elements(332) <= binary_1011_inst_ack_1;
    cpelement_group_333 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(310) & cp_elements(332) & cp_elements(334));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(333),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1016_inst_req_0 <= cp_elements(333);
    cp_elements(334) <= cp_elements(267);
    cp_elements(335) <= binary_1016_inst_ack_0;
    binary_1016_inst_req_1 <= cp_elements(335);
    cp_elements(336) <= binary_1016_inst_ack_1;
    cpelement_group_337 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(336) & cp_elements(338));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(337),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1022_inst_req_0 <= cp_elements(337);
    cp_elements(338) <= cp_elements(267);
    cp_elements(339) <= binary_1022_inst_ack_0;
    binary_1022_inst_req_1 <= cp_elements(339);
    cp_elements(340) <= binary_1022_inst_ack_1;
    cpelement_group_341 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(324) & cp_elements(340) & cp_elements(342));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(341),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1027_inst_req_0 <= cp_elements(341);
    cp_elements(342) <= cp_elements(267);
    cp_elements(343) <= binary_1027_inst_ack_0;
    binary_1027_inst_req_1 <= cp_elements(343);
    cp_elements(344) <= binary_1027_inst_ack_1;
    cpelement_group_345 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(346) & cp_elements(347));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(345),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1033_inst_req_0 <= cp_elements(345);
    cp_elements(346) <= cp_elements(267);
    cp_elements(347) <= cp_elements(289);
    cp_elements(348) <= binary_1033_inst_ack_0;
    binary_1033_inst_req_1 <= cp_elements(348);
    cp_elements(349) <= binary_1033_inst_ack_1;
    cpelement_group_350 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(351) & cp_elements(352));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(350),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1039_inst_req_0 <= cp_elements(350);
    cp_elements(351) <= cp_elements(267);
    cp_elements(352) <= cp_elements(289);
    cp_elements(353) <= binary_1039_inst_ack_0;
    binary_1039_inst_req_1 <= cp_elements(353);
    cp_elements(354) <= binary_1039_inst_ack_1;
    cpelement_group_355 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(356) & cp_elements(357));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(355),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1045_inst_req_0 <= cp_elements(355);
    cp_elements(356) <= cp_elements(267);
    cp_elements(357) <= cp_elements(289);
    cp_elements(358) <= binary_1045_inst_ack_0;
    binary_1045_inst_req_1 <= cp_elements(358);
    cp_elements(359) <= binary_1045_inst_ack_1;
    cpelement_group_360 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(359) & cp_elements(361));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(360),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1051_inst_req_0 <= cp_elements(360);
    cp_elements(361) <= cp_elements(267);
    cp_elements(362) <= binary_1051_inst_ack_0;
    binary_1051_inst_req_1 <= cp_elements(362);
    cp_elements(363) <= binary_1051_inst_ack_1;
    cpelement_group_364 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(349) & cp_elements(354) & cp_elements(365));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(364),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1056_inst_req_0 <= cp_elements(364);
    cp_elements(365) <= cp_elements(267);
    cp_elements(366) <= binary_1056_inst_ack_0;
    binary_1056_inst_req_1 <= cp_elements(366);
    cp_elements(367) <= binary_1056_inst_ack_1;
    cpelement_group_368 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(367) & cp_elements(369));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(368),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1062_inst_req_0 <= cp_elements(368);
    cp_elements(369) <= cp_elements(267);
    cp_elements(370) <= binary_1062_inst_ack_0;
    binary_1062_inst_req_1 <= cp_elements(370);
    cp_elements(371) <= binary_1062_inst_ack_1;
    cpelement_group_372 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(363) & cp_elements(371) & cp_elements(373));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(372),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1067_inst_req_0 <= cp_elements(372);
    cp_elements(373) <= cp_elements(267);
    cp_elements(374) <= binary_1067_inst_ack_0;
    binary_1067_inst_req_1 <= cp_elements(374);
    cp_elements(375) <= binary_1067_inst_ack_1;
    cpelement_group_376 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(377) & cp_elements(378));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(376),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1073_inst_req_0 <= cp_elements(376);
    cp_elements(377) <= cp_elements(267);
    cp_elements(378) <= cp_elements(295);
    cp_elements(379) <= binary_1073_inst_ack_0;
    binary_1073_inst_req_1 <= cp_elements(379);
    cp_elements(380) <= binary_1073_inst_ack_1;
    cpelement_group_381 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(382) & cp_elements(383));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(381),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1079_inst_req_0 <= cp_elements(381);
    cp_elements(382) <= cp_elements(267);
    cp_elements(383) <= cp_elements(295);
    cp_elements(384) <= binary_1079_inst_ack_0;
    binary_1079_inst_req_1 <= cp_elements(384);
    cp_elements(385) <= binary_1079_inst_ack_1;
    cpelement_group_386 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(387) & cp_elements(388));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(386),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1085_inst_req_0 <= cp_elements(386);
    cp_elements(387) <= cp_elements(267);
    cp_elements(388) <= cp_elements(295);
    cp_elements(389) <= binary_1085_inst_ack_0;
    binary_1085_inst_req_1 <= cp_elements(389);
    cp_elements(390) <= binary_1085_inst_ack_1;
    cpelement_group_391 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(392) & cp_elements(393));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(391),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1091_inst_req_0 <= cp_elements(391);
    cp_elements(392) <= cp_elements(267);
    cp_elements(393) <= cp_elements(295);
    cp_elements(394) <= binary_1091_inst_ack_0;
    binary_1091_inst_req_1 <= cp_elements(394);
    cp_elements(395) <= binary_1091_inst_ack_1;
    cpelement_group_396 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(397) & cp_elements(398));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(396),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1097_inst_req_0 <= cp_elements(396);
    cp_elements(397) <= cp_elements(267);
    cp_elements(398) <= cp_elements(295);
    cp_elements(399) <= binary_1097_inst_ack_0;
    binary_1097_inst_req_1 <= cp_elements(399);
    cp_elements(400) <= binary_1097_inst_ack_1;
    cpelement_group_401 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(400) & cp_elements(402));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(401),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1103_inst_req_0 <= cp_elements(401);
    cp_elements(402) <= cp_elements(267);
    cp_elements(403) <= binary_1103_inst_ack_0;
    binary_1103_inst_req_1 <= cp_elements(403);
    cp_elements(404) <= binary_1103_inst_ack_1;
    cpelement_group_405 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(380) & cp_elements(385) & cp_elements(406));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(405),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1108_inst_req_0 <= cp_elements(405);
    cp_elements(406) <= cp_elements(267);
    cp_elements(407) <= binary_1108_inst_ack_0;
    binary_1108_inst_req_1 <= cp_elements(407);
    cp_elements(408) <= binary_1108_inst_ack_1;
    cpelement_group_409 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(395) & cp_elements(408) & cp_elements(410));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(409),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1113_inst_req_0 <= cp_elements(409);
    cp_elements(410) <= cp_elements(267);
    cp_elements(411) <= binary_1113_inst_ack_0;
    binary_1113_inst_req_1 <= cp_elements(411);
    cp_elements(412) <= binary_1113_inst_ack_1;
    cpelement_group_413 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(390) & cp_elements(412) & cp_elements(414));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(413),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1118_inst_req_0 <= cp_elements(413);
    cp_elements(414) <= cp_elements(267);
    cp_elements(415) <= binary_1118_inst_ack_0;
    binary_1118_inst_req_1 <= cp_elements(415);
    cp_elements(416) <= binary_1118_inst_ack_1;
    cpelement_group_417 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(416) & cp_elements(418));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(417),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1124_inst_req_0 <= cp_elements(417);
    cp_elements(418) <= cp_elements(267);
    cp_elements(419) <= binary_1124_inst_ack_0;
    binary_1124_inst_req_1 <= cp_elements(419);
    cp_elements(420) <= binary_1124_inst_ack_1;
    cpelement_group_421 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(404) & cp_elements(420) & cp_elements(422));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(421),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1129_inst_req_0 <= cp_elements(421);
    cp_elements(422) <= cp_elements(267);
    cp_elements(423) <= binary_1129_inst_ack_0;
    binary_1129_inst_req_1 <= cp_elements(423);
    cp_elements(424) <= binary_1129_inst_ack_1;
    cpelement_group_425 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(426) & cp_elements(427));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(425),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1135_inst_req_0 <= cp_elements(425);
    cp_elements(426) <= cp_elements(267);
    cp_elements(427) <= cp_elements(267);
    cp_elements(428) <= binary_1135_inst_ack_0;
    binary_1135_inst_req_1 <= cp_elements(428);
    cp_elements(429) <= binary_1135_inst_ack_1;
    cpelement_group_430 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(429) & cp_elements(431));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(430),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1141_inst_req_0 <= cp_elements(430);
    cp_elements(431) <= cp_elements(267);
    cp_elements(432) <= binary_1141_inst_ack_0;
    binary_1141_inst_req_1 <= cp_elements(432);
    cp_elements(433) <= binary_1141_inst_ack_1;
    cpelement_group_434 : Block -- 
      signal predecessors: BooleanArray(3 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(344) & cp_elements(375) & cp_elements(424) & cp_elements(433));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(434),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(435) <= cp_elements(7);
    cp_elements(436) <= false;
    cp_elements(437) <= cp_elements(436);
    cp_elements(438) <= cp_elements(7);
    if_stmt_1143_branch_req_0 <= cp_elements(438);
    cp_elements(439) <= cp_elements(438);
    cp_elements(440) <= cp_elements(439);
    cp_elements(441) <= if_stmt_1143_branch_ack_1;
    cp_elements(442) <= cp_elements(439);
    cp_elements(443) <= if_stmt_1143_branch_ack_0;
    cp_elements(444) <= cp_elements(8);
    cp_elements(445) <= cp_elements(444);
    cpelement_group_446 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(445) & cp_elements(447));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(446),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_1150_gather_scatter_req_0 <= cp_elements(446);
    cp_elements(447) <= cp_elements(444);
    cp_elements(448) <= simple_obj_ref_1150_gather_scatter_ack_0;
    simple_obj_ref_1150_store_0_req_0 <= cp_elements(448);
    cp_elements(449) <= simple_obj_ref_1150_store_0_ack_0;
    simple_obj_ref_1150_store_0_req_1 <= cp_elements(449);
    cp_elements(450) <= simple_obj_ref_1150_store_0_ack_1;
    cp_elements(451) <= cp_elements(444);
    cpelement_group_452 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(451) & cp_elements(453));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(452),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_1153_gather_scatter_req_0 <= cp_elements(452);
    cp_elements(453) <= cp_elements(444);
    cp_elements(454) <= simple_obj_ref_1153_gather_scatter_ack_0;
    simple_obj_ref_1153_store_0_req_0 <= cp_elements(454);
    cp_elements(455) <= simple_obj_ref_1153_store_0_ack_0;
    simple_obj_ref_1153_store_0_req_1 <= cp_elements(455);
    cp_elements(456) <= simple_obj_ref_1153_store_0_ack_1;
    cp_elements(457) <= cp_elements(444);
    cpelement_group_458 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(457) & cp_elements(459));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(458),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_1156_gather_scatter_req_0 <= cp_elements(458);
    cp_elements(459) <= cp_elements(444);
    cp_elements(460) <= simple_obj_ref_1156_gather_scatter_ack_0;
    simple_obj_ref_1156_store_0_req_0 <= cp_elements(460);
    cp_elements(461) <= simple_obj_ref_1156_store_0_ack_0;
    simple_obj_ref_1156_store_0_req_1 <= cp_elements(461);
    cp_elements(462) <= simple_obj_ref_1156_store_0_ack_1;
    cpelement_group_463 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(450) & cp_elements(456) & cp_elements(462));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(463),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(464) <= call_stmt_1170_call_ack_0;
    call_stmt_1170_call_req_1 <= cp_elements(464);
    cp_elements(465) <= call_stmt_1170_call_ack_1;
    cp_elements(466) <= cp_elements(465);
    cpelement_group_467 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(468) & cp_elements(469));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(467),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1175_inst_req_0 <= cp_elements(467);
    cp_elements(468) <= cp_elements(466);
    cp_elements(469) <= cp_elements(466);
    cp_elements(470) <= binary_1175_inst_ack_0;
    binary_1175_inst_req_1 <= cp_elements(470);
    cp_elements(471) <= binary_1175_inst_ack_1;
    cpelement_group_472 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(471) & cp_elements(473));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(472),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1181_inst_req_0 <= cp_elements(472);
    cp_elements(473) <= cp_elements(466);
    cp_elements(474) <= binary_1181_inst_ack_0;
    binary_1181_inst_req_1 <= cp_elements(474);
    cp_elements(475) <= binary_1181_inst_ack_1;
    cp_elements(476) <= cp_elements(475);
    cp_elements(477) <= false;
    cp_elements(478) <= cp_elements(477);
    cp_elements(479) <= cp_elements(475);
    if_stmt_1183_branch_req_0 <= cp_elements(479);
    cp_elements(480) <= cp_elements(479);
    cp_elements(481) <= cp_elements(480);
    cp_elements(482) <= if_stmt_1183_branch_ack_1;
    cp_elements(483) <= cp_elements(480);
    cp_elements(484) <= if_stmt_1183_branch_ack_0;
    type_cast_1167_inst_req_0 <= cp_elements(484);
    cp_elements(485) <= cp_elements(224);
    cp_elements(486) <= cp_elements(485);
    type_cast_641_inst_req_0 <= cp_elements(486);
    cp_elements(487) <= type_cast_641_inst_ack_0;
    phi_stmt_635_req_1 <= cp_elements(487);
    cp_elements(488) <= cp_elements(485);
    cp_elements(489) <= cp_elements(488);
    cp_elements(490) <= cp_elements(488);
    type_cast_647_inst_req_0 <= cp_elements(490);
    cp_elements(491) <= type_cast_647_inst_ack_0;
    cpelement_group_492 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(489) & cp_elements(491));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(492),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_642_req_1 <= cp_elements(492);
    cp_elements(493) <= cp_elements(485);
    cp_elements(494) <= cp_elements(493);
    cp_elements(495) <= cp_elements(493);
    type_cast_653_inst_req_0 <= cp_elements(495);
    cp_elements(496) <= type_cast_653_inst_ack_0;
    cpelement_group_497 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(494) & cp_elements(496));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(497),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_648_req_1 <= cp_elements(497);
    cp_elements(498) <= cp_elements(485);
    cp_elements(499) <= cp_elements(498);
    cp_elements(500) <= cp_elements(498);
    type_cast_659_inst_req_0 <= cp_elements(500);
    cp_elements(501) <= type_cast_659_inst_ack_0;
    cpelement_group_502 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(499) & cp_elements(501));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(502),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_654_req_1 <= cp_elements(502);
    cpelement_group_503 : Block -- 
      signal predecessors: BooleanArray(3 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(487) & cp_elements(492) & cp_elements(497) & cp_elements(502));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(503),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(504) <= cp_elements(1);
    cp_elements(505) <= cp_elements(504);
    phi_stmt_635_req_0 <= cp_elements(505);
    cp_elements(506) <= cp_elements(504);
    cp_elements(507) <= cp_elements(506);
    type_cast_645_inst_req_0 <= cp_elements(507);
    cp_elements(508) <= type_cast_645_inst_ack_0;
    cp_elements(509) <= cp_elements(506);
    cpelement_group_510 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(508) & cp_elements(509));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(510),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_642_req_0 <= cp_elements(510);
    cp_elements(511) <= cp_elements(504);
    cp_elements(512) <= cp_elements(511);
    type_cast_651_inst_req_0 <= cp_elements(512);
    cp_elements(513) <= type_cast_651_inst_ack_0;
    cp_elements(514) <= cp_elements(511);
    cpelement_group_515 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(513) & cp_elements(514));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(515),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_648_req_0 <= cp_elements(515);
    cp_elements(516) <= cp_elements(504);
    cp_elements(517) <= cp_elements(516);
    type_cast_657_inst_req_0 <= cp_elements(517);
    cp_elements(518) <= type_cast_657_inst_ack_0;
    cp_elements(519) <= cp_elements(516);
    cpelement_group_520 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(518) & cp_elements(519));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(520),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_654_req_0 <= cp_elements(520);
    cpelement_group_521 : Block -- 
      signal predecessors: BooleanArray(3 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(505) & cp_elements(510) & cp_elements(515) & cp_elements(520));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(521),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(522) <= OrReduce(cp_elements(503) & cp_elements(521));
    cp_elements(523) <= cp_elements(522);
    cp_elements(524) <= phi_stmt_635_ack_0;
    cp_elements(525) <= phi_stmt_642_ack_0;
    cp_elements(526) <= phi_stmt_648_ack_0;
    cp_elements(527) <= phi_stmt_654_ack_0;
    cpelement_group_528 : Block -- 
      signal predecessors: BooleanArray(3 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(524) & cp_elements(525) & cp_elements(526) & cp_elements(527));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(528),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(529) <= false;
    cp_elements(530) <= cp_elements(529);
    cp_elements(531) <= cp_elements(443);
    cp_elements(532) <= cp_elements(531);
    type_cast_921_inst_req_0 <= cp_elements(532);
    cp_elements(533) <= type_cast_921_inst_ack_0;
    phi_stmt_915_req_1 <= cp_elements(533);
    cp_elements(534) <= cp_elements(531);
    cp_elements(535) <= cp_elements(534);
    cp_elements(536) <= cp_elements(534);
    type_cast_927_inst_req_0 <= cp_elements(536);
    cp_elements(537) <= type_cast_927_inst_ack_0;
    cpelement_group_538 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(535) & cp_elements(537));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(538),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_922_req_1 <= cp_elements(538);
    cp_elements(539) <= cp_elements(531);
    cp_elements(540) <= cp_elements(539);
    cp_elements(541) <= cp_elements(539);
    type_cast_933_inst_req_0 <= cp_elements(541);
    cp_elements(542) <= type_cast_933_inst_ack_0;
    cpelement_group_543 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(540) & cp_elements(542));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(543),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_928_req_1 <= cp_elements(543);
    cp_elements(544) <= cp_elements(531);
    cp_elements(545) <= cp_elements(544);
    cp_elements(546) <= cp_elements(544);
    type_cast_939_inst_req_0 <= cp_elements(546);
    cp_elements(547) <= type_cast_939_inst_ack_0;
    cpelement_group_548 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(545) & cp_elements(547));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(548),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_934_req_1 <= cp_elements(548);
    cpelement_group_549 : Block -- 
      signal predecessors: BooleanArray(3 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(533) & cp_elements(538) & cp_elements(543) & cp_elements(548));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(549),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(550) <= cp_elements(5);
    cp_elements(551) <= cp_elements(550);
    phi_stmt_915_req_0 <= cp_elements(551);
    cp_elements(552) <= cp_elements(550);
    cp_elements(553) <= cp_elements(552);
    type_cast_925_inst_req_0 <= cp_elements(553);
    cp_elements(554) <= type_cast_925_inst_ack_0;
    cp_elements(555) <= cp_elements(552);
    cpelement_group_556 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(554) & cp_elements(555));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(556),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_922_req_0 <= cp_elements(556);
    cp_elements(557) <= cp_elements(550);
    cp_elements(558) <= cp_elements(557);
    type_cast_931_inst_req_0 <= cp_elements(558);
    cp_elements(559) <= type_cast_931_inst_ack_0;
    cp_elements(560) <= cp_elements(557);
    cpelement_group_561 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(559) & cp_elements(560));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(561),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_928_req_0 <= cp_elements(561);
    cp_elements(562) <= cp_elements(550);
    cp_elements(563) <= cp_elements(562);
    type_cast_937_inst_req_0 <= cp_elements(563);
    cp_elements(564) <= type_cast_937_inst_ack_0;
    cp_elements(565) <= cp_elements(562);
    cpelement_group_566 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(564) & cp_elements(565));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(566),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    phi_stmt_934_req_0 <= cp_elements(566);
    cpelement_group_567 : Block -- 
      signal predecessors: BooleanArray(3 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(551) & cp_elements(556) & cp_elements(561) & cp_elements(566));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(567),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(568) <= OrReduce(cp_elements(549) & cp_elements(567));
    cp_elements(569) <= cp_elements(568);
    cp_elements(570) <= phi_stmt_915_ack_0;
    cp_elements(571) <= phi_stmt_922_ack_0;
    cp_elements(572) <= phi_stmt_928_ack_0;
    cp_elements(573) <= phi_stmt_934_ack_0;
    cpelement_group_574 : Block -- 
      signal predecessors: BooleanArray(3 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(570) & cp_elements(571) & cp_elements(572) & cp_elements(573));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(574),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(575) <= false;
    cp_elements(576) <= cp_elements(575);
    cp_elements(577) <= type_cast_1167_inst_ack_0;
    phi_stmt_1161_req_1 <= cp_elements(577);
    cp_elements(578) <= OrReduce(cp_elements(9) & cp_elements(577));
    cp_elements(579) <= cp_elements(578);
    cp_elements(580) <= phi_stmt_1161_ack_0;
    call_stmt_1170_call_req_0 <= cp_elements(580);
    cp_elements(581) <= false;
    cp_elements(582) <= cp_elements(581);
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal R1x_xpromoted9_626 : std_logic_vector(31 downto 0);
    signal R1x_xpromoted_906 : std_logic_vector(31 downto 0);
    signal R2x_xpromoted10_629 : std_logic_vector(31 downto 0);
    signal R2x_xpromoted_909 : std_logic_vector(31 downto 0);
    signal R3x_xpromoted11_632 : std_logic_vector(31 downto 0);
    signal R3x_xpromoted_912 : std_logic_vector(31 downto 0);
    signal array_obj_ref_669_final_offset : std_logic_vector(1 downto 0);
    signal array_obj_ref_669_offset_scale_factor_0 : std_logic_vector(1 downto 0);
    signal array_obj_ref_669_resized_base_address : std_logic_vector(1 downto 0);
    signal array_obj_ref_669_root_address : std_logic_vector(1 downto 0);
    signal exitcond17_1142 : std_logic_vector(0 downto 0);
    signal exitcond23_884 : std_logic_vector(0 downto 0);
    signal exitcond_1182 : std_logic_vector(0 downto 0);
    signal iNsTr_10_697 : std_logic_vector(31 downto 0);
    signal iNsTr_11_702 : std_logic_vector(31 downto 0);
    signal iNsTr_12_707 : std_logic_vector(31 downto 0);
    signal iNsTr_13_713 : std_logic_vector(31 downto 0);
    signal iNsTr_14_719 : std_logic_vector(31 downto 0);
    signal iNsTr_15_725 : std_logic_vector(31 downto 0);
    signal iNsTr_16_731 : std_logic_vector(31 downto 0);
    signal iNsTr_17_737 : std_logic_vector(31 downto 0);
    signal iNsTr_18_743 : std_logic_vector(31 downto 0);
    signal iNsTr_19_748 : std_logic_vector(31 downto 0);
    signal iNsTr_1_642 : std_logic_vector(31 downto 0);
    signal iNsTr_20_753 : std_logic_vector(31 downto 0);
    signal iNsTr_21_758 : std_logic_vector(31 downto 0);
    signal iNsTr_22_764 : std_logic_vector(31 downto 0);
    signal iNsTr_23_769 : std_logic_vector(31 downto 0);
    signal iNsTr_24_775 : std_logic_vector(31 downto 0);
    signal iNsTr_25_781 : std_logic_vector(31 downto 0);
    signal iNsTr_26_787 : std_logic_vector(31 downto 0);
    signal iNsTr_27_793 : std_logic_vector(31 downto 0);
    signal iNsTr_28_798 : std_logic_vector(31 downto 0);
    signal iNsTr_29_804 : std_logic_vector(31 downto 0);
    signal iNsTr_2_648 : std_logic_vector(31 downto 0);
    signal iNsTr_30_809 : std_logic_vector(31 downto 0);
    signal iNsTr_31_815 : std_logic_vector(31 downto 0);
    signal iNsTr_32_821 : std_logic_vector(31 downto 0);
    signal iNsTr_33_827 : std_logic_vector(31 downto 0);
    signal iNsTr_34_833 : std_logic_vector(31 downto 0);
    signal iNsTr_35_839 : std_logic_vector(31 downto 0);
    signal iNsTr_36_845 : std_logic_vector(31 downto 0);
    signal iNsTr_37_850 : std_logic_vector(31 downto 0);
    signal iNsTr_38_855 : std_logic_vector(31 downto 0);
    signal iNsTr_39_860 : std_logic_vector(31 downto 0);
    signal iNsTr_3_654 : std_logic_vector(31 downto 0);
    signal iNsTr_40_866 : std_logic_vector(31 downto 0);
    signal iNsTr_41_871 : std_logic_vector(31 downto 0);
    signal iNsTr_46_903 : std_logic_vector(31 downto 0);
    signal iNsTr_48_922 : std_logic_vector(31 downto 0);
    signal iNsTr_49_928 : std_logic_vector(31 downto 0);
    signal iNsTr_4_666 : std_logic_vector(31 downto 0);
    signal iNsTr_50_934 : std_logic_vector(31 downto 0);
    signal iNsTr_51_945 : std_logic_vector(31 downto 0);
    signal iNsTr_52_951 : std_logic_vector(31 downto 0);
    signal iNsTr_53_956 : std_logic_vector(31 downto 0);
    signal iNsTr_54_961 : std_logic_vector(31 downto 0);
    signal iNsTr_55_966 : std_logic_vector(31 downto 0);
    signal iNsTr_56_972 : std_logic_vector(31 downto 0);
    signal iNsTr_57_978 : std_logic_vector(31 downto 0);
    signal iNsTr_58_984 : std_logic_vector(31 downto 0);
    signal iNsTr_59_990 : std_logic_vector(31 downto 0);
    signal iNsTr_5_671 : std_logic_vector(31 downto 0);
    signal iNsTr_60_996 : std_logic_vector(31 downto 0);
    signal iNsTr_61_1002 : std_logic_vector(31 downto 0);
    signal iNsTr_62_1007 : std_logic_vector(31 downto 0);
    signal iNsTr_63_1012 : std_logic_vector(31 downto 0);
    signal iNsTr_64_1017 : std_logic_vector(31 downto 0);
    signal iNsTr_65_1023 : std_logic_vector(31 downto 0);
    signal iNsTr_66_1028 : std_logic_vector(31 downto 0);
    signal iNsTr_67_1034 : std_logic_vector(31 downto 0);
    signal iNsTr_68_1040 : std_logic_vector(31 downto 0);
    signal iNsTr_69_1046 : std_logic_vector(31 downto 0);
    signal iNsTr_6_675 : std_logic_vector(31 downto 0);
    signal iNsTr_70_1052 : std_logic_vector(31 downto 0);
    signal iNsTr_71_1057 : std_logic_vector(31 downto 0);
    signal iNsTr_72_1063 : std_logic_vector(31 downto 0);
    signal iNsTr_73_1068 : std_logic_vector(31 downto 0);
    signal iNsTr_74_1074 : std_logic_vector(31 downto 0);
    signal iNsTr_75_1080 : std_logic_vector(31 downto 0);
    signal iNsTr_76_1086 : std_logic_vector(31 downto 0);
    signal iNsTr_77_1092 : std_logic_vector(31 downto 0);
    signal iNsTr_78_1098 : std_logic_vector(31 downto 0);
    signal iNsTr_79_1104 : std_logic_vector(31 downto 0);
    signal iNsTr_7_681 : std_logic_vector(31 downto 0);
    signal iNsTr_80_1109 : std_logic_vector(31 downto 0);
    signal iNsTr_81_1114 : std_logic_vector(31 downto 0);
    signal iNsTr_82_1119 : std_logic_vector(31 downto 0);
    signal iNsTr_83_1125 : std_logic_vector(31 downto 0);
    signal iNsTr_84_1130 : std_logic_vector(31 downto 0);
    signal iNsTr_8_686 : std_logic_vector(31 downto 0);
    signal iNsTr_90_1170 : std_logic_vector(31 downto 0);
    signal iNsTr_91_1176 : std_logic_vector(7 downto 0);
    signal iNsTr_9_692 : std_logic_vector(31 downto 0);
    signal indvar21_635 : std_logic_vector(31 downto 0);
    signal indvar_915 : std_logic_vector(31 downto 0);
    signal indvarx_xnext22_877 : std_logic_vector(31 downto 0);
    signal indvarx_xnext_1136 : std_logic_vector(31 downto 0);
    signal ix_x21_1161 : std_logic_vector(7 downto 0);
    signal ptr_deref_674_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_674_resized_base_address : std_logic_vector(1 downto 0);
    signal ptr_deref_674_root_address : std_logic_vector(1 downto 0);
    signal ptr_deref_674_word_address_0 : std_logic_vector(1 downto 0);
    signal ptr_deref_674_word_offset_0 : std_logic_vector(1 downto 0);
    signal simple_obj_ref_1150_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_1150_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_1153_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_1153_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_1156_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_1156_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_625_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_625_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_628_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_628_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_631_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_631_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_668_resized : std_logic_vector(1 downto 0);
    signal simple_obj_ref_668_scaled : std_logic_vector(1 downto 0);
    signal simple_obj_ref_892_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_892_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_895_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_895_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_898_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_898_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_902_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_902_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_905_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_905_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_908_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_908_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_911_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_911_word_address_0 : std_logic_vector(0 downto 0);
    signal type_cast_1000_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1021_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1032_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1038_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1044_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1050_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1061_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1072_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1078_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1084_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1090_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1096_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1102_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1123_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1134_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1140_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1165_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_1167_wire : std_logic_vector(7 downto 0);
    signal type_cast_1174_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_1180_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_639_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_641_wire : std_logic_vector(31 downto 0);
    signal type_cast_645_wire : std_logic_vector(31 downto 0);
    signal type_cast_647_wire : std_logic_vector(31 downto 0);
    signal type_cast_651_wire : std_logic_vector(31 downto 0);
    signal type_cast_653_wire : std_logic_vector(31 downto 0);
    signal type_cast_657_wire : std_logic_vector(31 downto 0);
    signal type_cast_659_wire : std_logic_vector(31 downto 0);
    signal type_cast_664_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_679_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_690_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_711_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_717_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_723_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_729_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_735_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_741_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_762_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_773_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_779_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_785_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_791_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_802_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_813_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_819_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_825_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_831_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_837_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_843_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_864_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_875_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_881_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_919_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_921_wire : std_logic_vector(31 downto 0);
    signal type_cast_925_wire : std_logic_vector(31 downto 0);
    signal type_cast_927_wire : std_logic_vector(31 downto 0);
    signal type_cast_931_wire : std_logic_vector(31 downto 0);
    signal type_cast_933_wire : std_logic_vector(31 downto 0);
    signal type_cast_937_wire : std_logic_vector(31 downto 0);
    signal type_cast_939_wire : std_logic_vector(31 downto 0);
    signal type_cast_949_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_970_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_976_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_982_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_988_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_994_wire_constant : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    array_obj_ref_669_offset_scale_factor_0 <= "01";
    array_obj_ref_669_resized_base_address <= "00";
    ptr_deref_674_word_offset_0 <= "00";
    simple_obj_ref_1150_word_address_0 <= "0";
    simple_obj_ref_1153_word_address_0 <= "0";
    simple_obj_ref_1156_word_address_0 <= "0";
    simple_obj_ref_625_word_address_0 <= "0";
    simple_obj_ref_628_word_address_0 <= "0";
    simple_obj_ref_631_word_address_0 <= "0";
    simple_obj_ref_892_word_address_0 <= "0";
    simple_obj_ref_895_word_address_0 <= "0";
    simple_obj_ref_898_word_address_0 <= "0";
    simple_obj_ref_902_word_address_0 <= "0";
    simple_obj_ref_905_word_address_0 <= "0";
    simple_obj_ref_908_word_address_0 <= "0";
    simple_obj_ref_911_word_address_0 <= "0";
    type_cast_1000_wire_constant <= "00000000000001111111111111111110";
    type_cast_1021_wire_constant <= "00000000000000000000000000000001";
    type_cast_1032_wire_constant <= "00000000000000000000000000010101";
    type_cast_1038_wire_constant <= "00000000000000000000000000010100";
    type_cast_1044_wire_constant <= "00000000000000000000000000000001";
    type_cast_1050_wire_constant <= "00000000001111111111111111111110";
    type_cast_1061_wire_constant <= "00000000000000000000000000000001";
    type_cast_1072_wire_constant <= "00000000000000000000000000010110";
    type_cast_1078_wire_constant <= "00000000000000000000000000010101";
    type_cast_1084_wire_constant <= "00000000000000000000000000010100";
    type_cast_1090_wire_constant <= "00000000000000000000000000000111";
    type_cast_1096_wire_constant <= "00000000000000000000000000000001";
    type_cast_1102_wire_constant <= "00000000011111111111111111111110";
    type_cast_1123_wire_constant <= "00000000000000000000000000000001";
    type_cast_1134_wire_constant <= "00000000000000000000000000000001";
    type_cast_1140_wire_constant <= "00000000000000000000000000010110";
    type_cast_1165_wire_constant <= "00000000";
    type_cast_1174_wire_constant <= "00000001";
    type_cast_1180_wire_constant <= "01100100";
    type_cast_639_wire_constant <= "00000000000000000000000000000000";
    type_cast_664_wire_constant <= "00000000000000000000000000000101";
    type_cast_679_wire_constant <= "00000000000000000000000000011111";
    type_cast_690_wire_constant <= "00000000000000000000000000000001";
    type_cast_711_wire_constant <= "00000000000000000000000000010010";
    type_cast_717_wire_constant <= "00000000000000000000000000010001";
    type_cast_723_wire_constant <= "00000000000000000000000000010000";
    type_cast_729_wire_constant <= "00000000000000000000000000001101";
    type_cast_735_wire_constant <= "00000000000000000000000000000001";
    type_cast_741_wire_constant <= "00000000000001111111111111111110";
    type_cast_762_wire_constant <= "00000000000000000000000000000001";
    type_cast_773_wire_constant <= "00000000000000000000000000010101";
    type_cast_779_wire_constant <= "00000000000000000000000000010100";
    type_cast_785_wire_constant <= "00000000000000000000000000000001";
    type_cast_791_wire_constant <= "00000000001111111111111111111110";
    type_cast_802_wire_constant <= "00000000000000000000000000000001";
    type_cast_813_wire_constant <= "00000000000000000000000000010110";
    type_cast_819_wire_constant <= "00000000000000000000000000010101";
    type_cast_825_wire_constant <= "00000000000000000000000000010100";
    type_cast_831_wire_constant <= "00000000000000000000000000000111";
    type_cast_837_wire_constant <= "00000000000000000000000000000001";
    type_cast_843_wire_constant <= "00000000011111111111111111111110";
    type_cast_864_wire_constant <= "00000000000000000000000000000001";
    type_cast_875_wire_constant <= "00000000000000000000000000000001";
    type_cast_881_wire_constant <= "00000000000000000000000001000000";
    type_cast_919_wire_constant <= "00000000000000000000000000000000";
    type_cast_949_wire_constant <= "00000000000000000000000000000001";
    type_cast_970_wire_constant <= "00000000000000000000000000010010";
    type_cast_976_wire_constant <= "00000000000000000000000000010001";
    type_cast_982_wire_constant <= "00000000000000000000000000010000";
    type_cast_988_wire_constant <= "00000000000000000000000000001101";
    type_cast_994_wire_constant <= "00000000000000000000000000000001";
    phi_stmt_1161: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_1165_wire_constant & type_cast_1167_wire;
      req <= phi_stmt_1161_req_0 & phi_stmt_1161_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_1161_ack_0,
          idata => idata,
          odata => ix_x21_1161,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_1161
    phi_stmt_635: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_639_wire_constant & type_cast_641_wire;
      req <= phi_stmt_635_req_0 & phi_stmt_635_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_635_ack_0,
          idata => idata,
          odata => indvar21_635,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_635
    phi_stmt_642: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_645_wire & type_cast_647_wire;
      req <= phi_stmt_642_req_0 & phi_stmt_642_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_642_ack_0,
          idata => idata,
          odata => iNsTr_1_642,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_642
    phi_stmt_648: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_651_wire & type_cast_653_wire;
      req <= phi_stmt_648_req_0 & phi_stmt_648_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_648_ack_0,
          idata => idata,
          odata => iNsTr_2_648,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_648
    phi_stmt_654: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_657_wire & type_cast_659_wire;
      req <= phi_stmt_654_req_0 & phi_stmt_654_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_654_ack_0,
          idata => idata,
          odata => iNsTr_3_654,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_654
    phi_stmt_915: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_919_wire_constant & type_cast_921_wire;
      req <= phi_stmt_915_req_0 & phi_stmt_915_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_915_ack_0,
          idata => idata,
          odata => indvar_915,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_915
    phi_stmt_922: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_925_wire & type_cast_927_wire;
      req <= phi_stmt_922_req_0 & phi_stmt_922_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_922_ack_0,
          idata => idata,
          odata => iNsTr_48_922,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_922
    phi_stmt_928: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_931_wire & type_cast_933_wire;
      req <= phi_stmt_928_req_0 & phi_stmt_928_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_928_ack_0,
          idata => idata,
          odata => iNsTr_49_928,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_928
    phi_stmt_934: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_937_wire & type_cast_939_wire;
      req <= phi_stmt_934_req_0 & phi_stmt_934_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_934_ack_0,
          idata => idata,
          odata => iNsTr_50_934,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_934
    addr_of_670_final_reg: RegisterBase --
      generic map(in_data_width => 2,out_data_width => 32, flow_through => false ) 
      port map( din => array_obj_ref_669_root_address, dout => iNsTr_5_671, req => addr_of_670_final_reg_req_0, ack => addr_of_670_final_reg_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_669_index_0_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 2, flow_through => true ) 
      port map( din => iNsTr_4_666, dout => simple_obj_ref_668_resized, req => array_obj_ref_669_index_0_resize_req_0, ack => array_obj_ref_669_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_669_offset_inst: RegisterBase --
      generic map(in_data_width => 2,out_data_width => 2, flow_through => true ) 
      port map( din => simple_obj_ref_668_scaled, dout => array_obj_ref_669_final_offset, req => array_obj_ref_669_offset_inst_req_0, ack => array_obj_ref_669_offset_inst_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_674_base_resize: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 2, flow_through => true ) 
      port map( din => iNsTr_5_671, dout => ptr_deref_674_resized_base_address, req => ptr_deref_674_base_resize_req_0, ack => ptr_deref_674_base_resize_ack_0, clk => clk, reset => reset); -- 
    type_cast_1167_inst: RegisterBase --
      generic map(in_data_width => 8,out_data_width => 8, flow_through => true ) 
      port map( din => iNsTr_91_1176, dout => type_cast_1167_wire, req => type_cast_1167_inst_req_0, ack => type_cast_1167_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_641_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => indvarx_xnext22_877, dout => type_cast_641_wire, req => type_cast_641_inst_req_0, ack => type_cast_641_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_645_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => R3x_xpromoted11_632, dout => type_cast_645_wire, req => type_cast_645_inst_req_0, ack => type_cast_645_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_647_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => iNsTr_41_871, dout => type_cast_647_wire, req => type_cast_647_inst_req_0, ack => type_cast_647_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_651_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => R2x_xpromoted10_629, dout => type_cast_651_wire, req => type_cast_651_inst_req_0, ack => type_cast_651_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_653_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => iNsTr_30_809, dout => type_cast_653_wire, req => type_cast_653_inst_req_0, ack => type_cast_653_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_657_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => R1x_xpromoted9_626, dout => type_cast_657_wire, req => type_cast_657_inst_req_0, ack => type_cast_657_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_659_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => iNsTr_23_769, dout => type_cast_659_wire, req => type_cast_659_inst_req_0, ack => type_cast_659_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_921_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => indvarx_xnext_1136, dout => type_cast_921_wire, req => type_cast_921_inst_req_0, ack => type_cast_921_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_925_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => R3x_xpromoted_912, dout => type_cast_925_wire, req => type_cast_925_inst_req_0, ack => type_cast_925_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_927_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => iNsTr_84_1130, dout => type_cast_927_wire, req => type_cast_927_inst_req_0, ack => type_cast_927_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_931_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => R2x_xpromoted_909, dout => type_cast_931_wire, req => type_cast_931_inst_req_0, ack => type_cast_931_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_933_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => iNsTr_73_1068, dout => type_cast_933_wire, req => type_cast_933_inst_req_0, ack => type_cast_933_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_937_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => R1x_xpromoted_906, dout => type_cast_937_wire, req => type_cast_937_inst_req_0, ack => type_cast_937_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_939_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => iNsTr_66_1028, dout => type_cast_939_wire, req => type_cast_939_inst_req_0, ack => type_cast_939_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_669_index_0_rename: Block -- 
      signal aggregated_sig: std_logic_vector(1 downto 0); --
    begin -- 
      array_obj_ref_669_index_0_rename_ack_0 <= array_obj_ref_669_index_0_rename_req_0;
      aggregated_sig <= simple_obj_ref_668_resized;
      simple_obj_ref_668_scaled <= aggregated_sig(1 downto 0);
      --
    end Block;
    array_obj_ref_669_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(1 downto 0); --
    begin -- 
      array_obj_ref_669_root_address_inst_ack_0 <= array_obj_ref_669_root_address_inst_req_0;
      aggregated_sig <= array_obj_ref_669_final_offset;
      array_obj_ref_669_root_address <= aggregated_sig(1 downto 0);
      --
    end Block;
    ptr_deref_674_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(1 downto 0); --
    begin -- 
      ptr_deref_674_addr_0_ack_0 <= ptr_deref_674_addr_0_req_0;
      aggregated_sig <= ptr_deref_674_root_address;
      ptr_deref_674_word_address_0 <= aggregated_sig(1 downto 0);
      --
    end Block;
    ptr_deref_674_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_674_gather_scatter_ack_0 <= ptr_deref_674_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_674_data_0;
      iNsTr_6_675 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_674_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(1 downto 0); --
    begin -- 
      ptr_deref_674_root_address_inst_ack_0 <= ptr_deref_674_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_674_resized_base_address;
      ptr_deref_674_root_address <= aggregated_sig(1 downto 0);
      --
    end Block;
    simple_obj_ref_1150_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_1150_gather_scatter_ack_0 <= simple_obj_ref_1150_gather_scatter_req_0;
      aggregated_sig <= iNsTr_84_1130;
      simple_obj_ref_1150_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_1153_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_1153_gather_scatter_ack_0 <= simple_obj_ref_1153_gather_scatter_req_0;
      aggregated_sig <= iNsTr_73_1068;
      simple_obj_ref_1153_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_1156_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_1156_gather_scatter_ack_0 <= simple_obj_ref_1156_gather_scatter_req_0;
      aggregated_sig <= iNsTr_66_1028;
      simple_obj_ref_1156_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_625_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_625_gather_scatter_ack_0 <= simple_obj_ref_625_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_625_data_0;
      R1x_xpromoted9_626 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_628_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_628_gather_scatter_ack_0 <= simple_obj_ref_628_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_628_data_0;
      R2x_xpromoted10_629 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_631_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_631_gather_scatter_ack_0 <= simple_obj_ref_631_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_631_data_0;
      R3x_xpromoted11_632 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_892_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_892_gather_scatter_ack_0 <= simple_obj_ref_892_gather_scatter_req_0;
      aggregated_sig <= iNsTr_41_871;
      simple_obj_ref_892_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_895_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_895_gather_scatter_ack_0 <= simple_obj_ref_895_gather_scatter_req_0;
      aggregated_sig <= iNsTr_30_809;
      simple_obj_ref_895_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_898_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_898_gather_scatter_ack_0 <= simple_obj_ref_898_gather_scatter_req_0;
      aggregated_sig <= iNsTr_23_769;
      simple_obj_ref_898_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_902_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_902_gather_scatter_ack_0 <= simple_obj_ref_902_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_902_data_0;
      iNsTr_46_903 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_905_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_905_gather_scatter_ack_0 <= simple_obj_ref_905_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_905_data_0;
      R1x_xpromoted_906 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_908_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_908_gather_scatter_ack_0 <= simple_obj_ref_908_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_908_data_0;
      R2x_xpromoted_909 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_911_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_911_gather_scatter_ack_0 <= simple_obj_ref_911_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_911_data_0;
      R3x_xpromoted_912 <= aggregated_sig(31 downto 0);
      --
    end Block;
    if_stmt_1143_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= exitcond17_1142;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_1143_branch_req_0,
          ack0 => if_stmt_1143_branch_ack_0,
          ack1 => if_stmt_1143_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    if_stmt_1183_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= exitcond_1182;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_1183_branch_req_0,
          ack0 => if_stmt_1183_branch_ack_0,
          ack1 => if_stmt_1183_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    if_stmt_885_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= exitcond23_884;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_885_branch_req_0,
          ack0 => if_stmt_885_branch_ack_0,
          ack1 => if_stmt_885_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : binary_1001_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_60_996;
      iNsTr_61_1002 <= data_out(31 downto 0);
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
          constant_operand => "00000000000001111111111111111110",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1001_inst_req_0,
          ackL => binary_1001_inst_ack_0,
          reqR => binary_1001_inst_req_1,
          ackR => binary_1001_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : binary_1006_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_57_978 & iNsTr_56_972;
      iNsTr_62_1007 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_1006_inst_req_0,
          ackL => binary_1006_inst_ack_0,
          reqR => binary_1006_inst_req_1,
          ackR => binary_1006_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : binary_1011_inst 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_62_1007 & iNsTr_59_990;
      iNsTr_63_1012 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_1011_inst_req_0,
          ackL => binary_1011_inst_ack_0,
          reqR => binary_1011_inst_req_1,
          ackR => binary_1011_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : binary_1016_inst 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_63_1012 & iNsTr_58_984;
      iNsTr_64_1017 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_1016_inst_req_0,
          ackL => binary_1016_inst_ack_0,
          reqR => binary_1016_inst_req_1,
          ackR => binary_1016_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : binary_1022_inst 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_64_1017;
      iNsTr_65_1023 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1022_inst_req_0,
          ackL => binary_1022_inst_ack_0,
          reqR => binary_1022_inst_req_1,
          ackR => binary_1022_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared split operator group (5) : binary_1027_inst 
    SplitOperatorGroup5: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_65_1023 & iNsTr_61_1002;
      iNsTr_66_1028 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_1027_inst_req_0,
          ackL => binary_1027_inst_ack_0,
          reqR => binary_1027_inst_req_1,
          ackR => binary_1027_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 5
    -- shared split operator group (6) : binary_1033_inst 
    SplitOperatorGroup6: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_54_961;
      iNsTr_67_1034 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010101",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1033_inst_req_0,
          ackL => binary_1033_inst_ack_0,
          reqR => binary_1033_inst_req_1,
          ackR => binary_1033_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 6
    -- shared split operator group (7) : binary_1039_inst 
    SplitOperatorGroup7: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_54_961;
      iNsTr_68_1040 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010100",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1039_inst_req_0,
          ackL => binary_1039_inst_ack_0,
          reqR => binary_1039_inst_req_1,
          ackR => binary_1039_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 7
    -- shared split operator group (8) : binary_1045_inst 
    SplitOperatorGroup8: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_54_961;
      iNsTr_69_1046 <= data_out(31 downto 0);
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
          reqL => binary_1045_inst_req_0,
          ackL => binary_1045_inst_ack_0,
          reqR => binary_1045_inst_req_1,
          ackR => binary_1045_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 8
    -- shared split operator group (9) : binary_1051_inst 
    SplitOperatorGroup9: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_69_1046;
      iNsTr_70_1052 <= data_out(31 downto 0);
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
          constant_operand => "00000000001111111111111111111110",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1051_inst_req_0,
          ackL => binary_1051_inst_ack_0,
          reqR => binary_1051_inst_req_1,
          ackR => binary_1051_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 9
    -- shared split operator group (10) : binary_1056_inst 
    SplitOperatorGroup10: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_67_1034 & iNsTr_68_1040;
      iNsTr_71_1057 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_1056_inst_req_0,
          ackL => binary_1056_inst_ack_0,
          reqR => binary_1056_inst_req_1,
          ackR => binary_1056_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 10
    -- shared split operator group (11) : binary_1062_inst 
    SplitOperatorGroup11: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_71_1057;
      iNsTr_72_1063 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1062_inst_req_0,
          ackL => binary_1062_inst_ack_0,
          reqR => binary_1062_inst_req_1,
          ackR => binary_1062_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 11
    -- shared split operator group (12) : binary_1067_inst 
    SplitOperatorGroup12: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_72_1063 & iNsTr_70_1052;
      iNsTr_73_1068 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_1067_inst_req_0,
          ackL => binary_1067_inst_ack_0,
          reqR => binary_1067_inst_req_1,
          ackR => binary_1067_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 12
    -- shared split operator group (13) : binary_1073_inst 
    SplitOperatorGroup13: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_55_966;
      iNsTr_74_1074 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010110",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1073_inst_req_0,
          ackL => binary_1073_inst_ack_0,
          reqR => binary_1073_inst_req_1,
          ackR => binary_1073_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 13
    -- shared split operator group (14) : binary_1079_inst 
    SplitOperatorGroup14: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_55_966;
      iNsTr_75_1080 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010101",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1079_inst_req_0,
          ackL => binary_1079_inst_ack_0,
          reqR => binary_1079_inst_req_1,
          ackR => binary_1079_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 14
    -- shared split operator group (15) : binary_1085_inst 
    SplitOperatorGroup15: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_55_966;
      iNsTr_76_1086 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010100",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1085_inst_req_0,
          ackL => binary_1085_inst_ack_0,
          reqR => binary_1085_inst_req_1,
          ackR => binary_1085_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 15
    -- shared split operator group (16) : binary_1091_inst 
    SplitOperatorGroup16: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_55_966;
      iNsTr_77_1092 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000111",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1091_inst_req_0,
          ackL => binary_1091_inst_ack_0,
          reqR => binary_1091_inst_req_1,
          ackR => binary_1091_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 16
    -- shared split operator group (17) : binary_1097_inst 
    SplitOperatorGroup17: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_55_966;
      iNsTr_78_1098 <= data_out(31 downto 0);
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
          reqL => binary_1097_inst_req_0,
          ackL => binary_1097_inst_ack_0,
          reqR => binary_1097_inst_req_1,
          ackR => binary_1097_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 17
    -- shared split operator group (18) : binary_1103_inst 
    SplitOperatorGroup18: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_78_1098;
      iNsTr_79_1104 <= data_out(31 downto 0);
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
          constant_operand => "00000000011111111111111111111110",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1103_inst_req_0,
          ackL => binary_1103_inst_ack_0,
          reqR => binary_1103_inst_req_1,
          ackR => binary_1103_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 18
    -- shared split operator group (19) : binary_1108_inst 
    SplitOperatorGroup19: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_75_1080 & iNsTr_74_1074;
      iNsTr_80_1109 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_1108_inst_req_0,
          ackL => binary_1108_inst_ack_0,
          reqR => binary_1108_inst_req_1,
          ackR => binary_1108_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 19
    -- shared split operator group (20) : binary_1113_inst 
    SplitOperatorGroup20: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_80_1109 & iNsTr_77_1092;
      iNsTr_81_1114 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_1113_inst_req_0,
          ackL => binary_1113_inst_ack_0,
          reqR => binary_1113_inst_req_1,
          ackR => binary_1113_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 20
    -- shared split operator group (21) : binary_1118_inst 
    SplitOperatorGroup21: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_81_1114 & iNsTr_76_1086;
      iNsTr_82_1119 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_1118_inst_req_0,
          ackL => binary_1118_inst_ack_0,
          reqR => binary_1118_inst_req_1,
          ackR => binary_1118_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 21
    -- shared split operator group (22) : binary_1124_inst 
    SplitOperatorGroup22: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_82_1119;
      iNsTr_83_1125 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1124_inst_req_0,
          ackL => binary_1124_inst_ack_0,
          reqR => binary_1124_inst_req_1,
          ackR => binary_1124_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 22
    -- shared split operator group (23) : binary_1129_inst 
    SplitOperatorGroup23: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_83_1125 & iNsTr_79_1104;
      iNsTr_84_1130 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_1129_inst_req_0,
          ackL => binary_1129_inst_ack_0,
          reqR => binary_1129_inst_req_1,
          ackR => binary_1129_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 23
    -- shared split operator group (24) : binary_876_inst binary_1135_inst 
    SplitOperatorGroup24: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      data_in <= indvar21_635 & indvar_915;
      indvarx_xnext22_877 <= data_out(63 downto 32);
      indvarx_xnext_1136 <= data_out(31 downto 0);
      reqL(1) <= binary_876_inst_req_0;
      reqL(0) <= binary_1135_inst_req_0;
      binary_876_inst_ack_0 <= ackL(1);
      binary_1135_inst_ack_0 <= ackL(0);
      reqR(1) <= binary_876_inst_req_1;
      reqR(0) <= binary_1135_inst_req_1;
      binary_876_inst_ack_1 <= ackR(1);
      binary_1135_inst_ack_1 <= ackR(0);
      SplitOperator: SplitOperatorShared -- 
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
          no_arbitration => true,
          min_clock_period => true,
          num_reqs => 2--
        ) -- 
      port map ( reqL => reqL , ackL => ackL, reqR => reqR, ackR => ackR, dataL => data_in, dataR => data_out, clk => clk, reset => reset);
      -- 
    end Block; -- split operator group 24
    -- shared split operator group (25) : binary_1141_inst 
    SplitOperatorGroup25: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= indvarx_xnext_1136;
      exitcond17_1142 <= data_out(0 downto 0);
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
          constant_operand => "00000000000000000000000000010110",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1141_inst_req_0,
          ackL => binary_1141_inst_ack_0,
          reqR => binary_1141_inst_req_1,
          ackR => binary_1141_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 25
    -- shared split operator group (26) : binary_1175_inst 
    SplitOperatorGroup26: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= ix_x21_1161;
      iNsTr_91_1176 <= data_out(7 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
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
          owidth => 8,
          constant_operand => "00000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1175_inst_req_0,
          ackL => binary_1175_inst_ack_0,
          reqR => binary_1175_inst_req_1,
          ackR => binary_1175_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 26
    -- shared split operator group (27) : binary_1181_inst 
    SplitOperatorGroup27: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_91_1176;
      exitcond_1182 <= data_out(0 downto 0);
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
          constant_operand => "01100100",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1181_inst_req_0,
          ackL => binary_1181_inst_ack_0,
          reqR => binary_1181_inst_req_1,
          ackR => binary_1181_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 27
    -- shared split operator group (28) : binary_665_inst 
    SplitOperatorGroup28: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= indvar21_635;
      iNsTr_4_666 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000101",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_665_inst_req_0,
          ackL => binary_665_inst_ack_0,
          reqR => binary_665_inst_req_1,
          ackR => binary_665_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 28
    -- shared split operator group (29) : binary_680_inst 
    SplitOperatorGroup29: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= indvar21_635;
      iNsTr_7_681 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000011111",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_680_inst_req_0,
          ackL => binary_680_inst_ack_0,
          reqR => binary_680_inst_req_1,
          ackR => binary_680_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 29
    -- shared split operator group (30) : binary_685_inst binary_944_inst 
    SplitOperatorGroup30: Block -- 
      signal data_in: std_logic_vector(127 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_6_675 & iNsTr_7_681 & iNsTr_46_903 & indvar_915;
      iNsTr_8_686 <= data_out(63 downto 32);
      iNsTr_51_945 <= data_out(31 downto 0);
      reqL(1) <= binary_685_inst_req_0;
      reqL(0) <= binary_944_inst_req_0;
      binary_685_inst_ack_0 <= ackL(1);
      binary_944_inst_ack_0 <= ackL(0);
      reqR(1) <= binary_685_inst_req_1;
      reqR(0) <= binary_944_inst_req_1;
      binary_685_inst_ack_1 <= ackR(1);
      binary_944_inst_ack_1 <= ackR(0);
      SplitOperator: SplitOperatorShared -- 
        generic map ( -- 
          operator_id => "ApIntLSHR",
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
          no_arbitration => true,
          min_clock_period => true,
          num_reqs => 2--
        ) -- 
      port map ( reqL => reqL , ackL => ackL, reqR => reqR, ackR => ackR, dataL => data_in, dataR => data_out, clk => clk, reset => reset);
      -- 
    end Block; -- split operator group 30
    -- shared split operator group (31) : binary_691_inst 
    SplitOperatorGroup31: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_8_686;
      iNsTr_9_692 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_691_inst_req_0,
          ackL => binary_691_inst_ack_0,
          reqR => binary_691_inst_req_1,
          ackR => binary_691_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 31
    -- shared split operator group (32) : binary_696_inst 
    SplitOperatorGroup32: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_9_692 & iNsTr_3_654;
      iNsTr_10_697 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_696_inst_req_0,
          ackL => binary_696_inst_ack_0,
          reqR => binary_696_inst_req_1,
          ackR => binary_696_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 32
    -- shared split operator group (33) : binary_701_inst 
    SplitOperatorGroup33: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_2_648 & iNsTr_9_692;
      iNsTr_11_702 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_701_inst_req_0,
          ackL => binary_701_inst_ack_0,
          reqR => binary_701_inst_req_1,
          ackR => binary_701_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 33
    -- shared split operator group (34) : binary_706_inst 
    SplitOperatorGroup34: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_1_642 & iNsTr_9_692;
      iNsTr_12_707 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_706_inst_req_0,
          ackL => binary_706_inst_ack_0,
          reqR => binary_706_inst_req_1,
          ackR => binary_706_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 34
    -- shared split operator group (35) : binary_712_inst 
    SplitOperatorGroup35: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_10_697;
      iNsTr_13_713 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010010",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_712_inst_req_0,
          ackL => binary_712_inst_ack_0,
          reqR => binary_712_inst_req_1,
          ackR => binary_712_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 35
    -- shared split operator group (36) : binary_718_inst 
    SplitOperatorGroup36: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_10_697;
      iNsTr_14_719 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_718_inst_req_0,
          ackL => binary_718_inst_ack_0,
          reqR => binary_718_inst_req_1,
          ackR => binary_718_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 36
    -- shared split operator group (37) : binary_724_inst 
    SplitOperatorGroup37: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_10_697;
      iNsTr_15_725 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_724_inst_req_0,
          ackL => binary_724_inst_ack_0,
          reqR => binary_724_inst_req_1,
          ackR => binary_724_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 37
    -- shared split operator group (38) : binary_730_inst 
    SplitOperatorGroup38: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_10_697;
      iNsTr_16_731 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000001101",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_730_inst_req_0,
          ackL => binary_730_inst_ack_0,
          reqR => binary_730_inst_req_1,
          ackR => binary_730_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 38
    -- shared split operator group (39) : binary_736_inst 
    SplitOperatorGroup39: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_10_697;
      iNsTr_17_737 <= data_out(31 downto 0);
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
          reqL => binary_736_inst_req_0,
          ackL => binary_736_inst_ack_0,
          reqR => binary_736_inst_req_1,
          ackR => binary_736_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 39
    -- shared split operator group (40) : binary_742_inst 
    SplitOperatorGroup40: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_17_737;
      iNsTr_18_743 <= data_out(31 downto 0);
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
          constant_operand => "00000000000001111111111111111110",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_742_inst_req_0,
          ackL => binary_742_inst_ack_0,
          reqR => binary_742_inst_req_1,
          ackR => binary_742_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 40
    -- shared split operator group (41) : binary_747_inst 
    SplitOperatorGroup41: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_14_719 & iNsTr_13_713;
      iNsTr_19_748 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_747_inst_req_0,
          ackL => binary_747_inst_ack_0,
          reqR => binary_747_inst_req_1,
          ackR => binary_747_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 41
    -- shared split operator group (42) : binary_752_inst 
    SplitOperatorGroup42: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_19_748 & iNsTr_16_731;
      iNsTr_20_753 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_752_inst_req_0,
          ackL => binary_752_inst_ack_0,
          reqR => binary_752_inst_req_1,
          ackR => binary_752_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 42
    -- shared split operator group (43) : binary_757_inst 
    SplitOperatorGroup43: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_20_753 & iNsTr_15_725;
      iNsTr_21_758 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_757_inst_req_0,
          ackL => binary_757_inst_ack_0,
          reqR => binary_757_inst_req_1,
          ackR => binary_757_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 43
    -- shared split operator group (44) : binary_763_inst 
    SplitOperatorGroup44: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_21_758;
      iNsTr_22_764 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
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
    end Block; -- split operator group 44
    -- shared split operator group (45) : binary_768_inst 
    SplitOperatorGroup45: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_22_764 & iNsTr_18_743;
      iNsTr_23_769 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_768_inst_req_0,
          ackL => binary_768_inst_ack_0,
          reqR => binary_768_inst_req_1,
          ackR => binary_768_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 45
    -- shared split operator group (46) : binary_774_inst 
    SplitOperatorGroup46: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_11_702;
      iNsTr_24_775 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010101",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_774_inst_req_0,
          ackL => binary_774_inst_ack_0,
          reqR => binary_774_inst_req_1,
          ackR => binary_774_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 46
    -- shared split operator group (47) : binary_780_inst 
    SplitOperatorGroup47: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_11_702;
      iNsTr_25_781 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010100",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_780_inst_req_0,
          ackL => binary_780_inst_ack_0,
          reqR => binary_780_inst_req_1,
          ackR => binary_780_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 47
    -- shared split operator group (48) : binary_786_inst 
    SplitOperatorGroup48: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_11_702;
      iNsTr_26_787 <= data_out(31 downto 0);
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
          reqL => binary_786_inst_req_0,
          ackL => binary_786_inst_ack_0,
          reqR => binary_786_inst_req_1,
          ackR => binary_786_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 48
    -- shared split operator group (49) : binary_792_inst 
    SplitOperatorGroup49: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_26_787;
      iNsTr_27_793 <= data_out(31 downto 0);
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
          constant_operand => "00000000001111111111111111111110",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_792_inst_req_0,
          ackL => binary_792_inst_ack_0,
          reqR => binary_792_inst_req_1,
          ackR => binary_792_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 49
    -- shared split operator group (50) : binary_797_inst 
    SplitOperatorGroup50: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_24_775 & iNsTr_25_781;
      iNsTr_28_798 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_797_inst_req_0,
          ackL => binary_797_inst_ack_0,
          reqR => binary_797_inst_req_1,
          ackR => binary_797_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 50
    -- shared split operator group (51) : binary_803_inst 
    SplitOperatorGroup51: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_28_798;
      iNsTr_29_804 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_803_inst_req_0,
          ackL => binary_803_inst_ack_0,
          reqR => binary_803_inst_req_1,
          ackR => binary_803_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 51
    -- shared split operator group (52) : binary_808_inst 
    SplitOperatorGroup52: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_29_804 & iNsTr_27_793;
      iNsTr_30_809 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_808_inst_req_0,
          ackL => binary_808_inst_ack_0,
          reqR => binary_808_inst_req_1,
          ackR => binary_808_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 52
    -- shared split operator group (53) : binary_814_inst 
    SplitOperatorGroup53: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_12_707;
      iNsTr_31_815 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010110",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_814_inst_req_0,
          ackL => binary_814_inst_ack_0,
          reqR => binary_814_inst_req_1,
          ackR => binary_814_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 53
    -- shared split operator group (54) : binary_820_inst 
    SplitOperatorGroup54: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_12_707;
      iNsTr_32_821 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010101",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_820_inst_req_0,
          ackL => binary_820_inst_ack_0,
          reqR => binary_820_inst_req_1,
          ackR => binary_820_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 54
    -- shared split operator group (55) : binary_826_inst 
    SplitOperatorGroup55: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_12_707;
      iNsTr_33_827 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010100",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_826_inst_req_0,
          ackL => binary_826_inst_ack_0,
          reqR => binary_826_inst_req_1,
          ackR => binary_826_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 55
    -- shared split operator group (56) : binary_832_inst 
    SplitOperatorGroup56: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_12_707;
      iNsTr_34_833 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000111",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_832_inst_req_0,
          ackL => binary_832_inst_ack_0,
          reqR => binary_832_inst_req_1,
          ackR => binary_832_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 56
    -- shared split operator group (57) : binary_838_inst 
    SplitOperatorGroup57: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_12_707;
      iNsTr_35_839 <= data_out(31 downto 0);
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
          reqL => binary_838_inst_req_0,
          ackL => binary_838_inst_ack_0,
          reqR => binary_838_inst_req_1,
          ackR => binary_838_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 57
    -- shared split operator group (58) : binary_844_inst 
    SplitOperatorGroup58: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_35_839;
      iNsTr_36_845 <= data_out(31 downto 0);
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
          constant_operand => "00000000011111111111111111111110",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_844_inst_req_0,
          ackL => binary_844_inst_ack_0,
          reqR => binary_844_inst_req_1,
          ackR => binary_844_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 58
    -- shared split operator group (59) : binary_849_inst 
    SplitOperatorGroup59: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_32_821 & iNsTr_31_815;
      iNsTr_37_850 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_849_inst_req_0,
          ackL => binary_849_inst_ack_0,
          reqR => binary_849_inst_req_1,
          ackR => binary_849_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 59
    -- shared split operator group (60) : binary_854_inst 
    SplitOperatorGroup60: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_37_850 & iNsTr_34_833;
      iNsTr_38_855 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_854_inst_req_0,
          ackL => binary_854_inst_ack_0,
          reqR => binary_854_inst_req_1,
          ackR => binary_854_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 60
    -- shared split operator group (61) : binary_859_inst 
    SplitOperatorGroup61: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_38_855 & iNsTr_33_827;
      iNsTr_39_860 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_859_inst_req_0,
          ackL => binary_859_inst_ack_0,
          reqR => binary_859_inst_req_1,
          ackR => binary_859_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 61
    -- shared split operator group (62) : binary_865_inst 
    SplitOperatorGroup62: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_39_860;
      iNsTr_40_866 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_865_inst_req_0,
          ackL => binary_865_inst_ack_0,
          reqR => binary_865_inst_req_1,
          ackR => binary_865_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 62
    -- shared split operator group (63) : binary_870_inst 
    SplitOperatorGroup63: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_40_866 & iNsTr_36_845;
      iNsTr_41_871 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_870_inst_req_0,
          ackL => binary_870_inst_ack_0,
          reqR => binary_870_inst_req_1,
          ackR => binary_870_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 63
    -- shared split operator group (64) : binary_882_inst 
    SplitOperatorGroup64: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= indvarx_xnext22_877;
      exitcond23_884 <= data_out(0 downto 0);
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
          constant_operand => "00000000000000000000000001000000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_882_inst_req_0,
          ackL => binary_882_inst_ack_0,
          reqR => binary_882_inst_req_1,
          ackR => binary_882_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 64
    -- shared split operator group (65) : binary_950_inst 
    SplitOperatorGroup65: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_51_945;
      iNsTr_52_951 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_950_inst_req_0,
          ackL => binary_950_inst_ack_0,
          reqR => binary_950_inst_req_1,
          ackR => binary_950_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 65
    -- shared split operator group (66) : binary_955_inst 
    SplitOperatorGroup66: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_52_951 & iNsTr_50_934;
      iNsTr_53_956 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_955_inst_req_0,
          ackL => binary_955_inst_ack_0,
          reqR => binary_955_inst_req_1,
          ackR => binary_955_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 66
    -- shared split operator group (67) : binary_960_inst 
    SplitOperatorGroup67: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_49_928 & iNsTr_52_951;
      iNsTr_54_961 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_960_inst_req_0,
          ackL => binary_960_inst_ack_0,
          reqR => binary_960_inst_req_1,
          ackR => binary_960_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 67
    -- shared split operator group (68) : binary_965_inst 
    SplitOperatorGroup68: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_48_922 & iNsTr_52_951;
      iNsTr_55_966 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_965_inst_req_0,
          ackL => binary_965_inst_ack_0,
          reqR => binary_965_inst_req_1,
          ackR => binary_965_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 68
    -- shared split operator group (69) : binary_971_inst 
    SplitOperatorGroup69: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_53_956;
      iNsTr_56_972 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010010",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_971_inst_req_0,
          ackL => binary_971_inst_ack_0,
          reqR => binary_971_inst_req_1,
          ackR => binary_971_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 69
    -- shared split operator group (70) : binary_977_inst 
    SplitOperatorGroup70: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_53_956;
      iNsTr_57_978 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_977_inst_req_0,
          ackL => binary_977_inst_ack_0,
          reqR => binary_977_inst_req_1,
          ackR => binary_977_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 70
    -- shared split operator group (71) : binary_983_inst 
    SplitOperatorGroup71: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_53_956;
      iNsTr_58_984 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_983_inst_req_0,
          ackL => binary_983_inst_ack_0,
          reqR => binary_983_inst_req_1,
          ackR => binary_983_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 71
    -- shared split operator group (72) : binary_989_inst 
    SplitOperatorGroup72: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_53_956;
      iNsTr_59_990 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000001101",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_989_inst_req_0,
          ackL => binary_989_inst_ack_0,
          reqR => binary_989_inst_req_1,
          ackR => binary_989_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 72
    -- shared split operator group (73) : binary_995_inst 
    SplitOperatorGroup73: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_53_956;
      iNsTr_60_996 <= data_out(31 downto 0);
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
          reqL => binary_995_inst_req_0,
          ackL => binary_995_inst_ack_0,
          reqR => binary_995_inst_req_1,
          ackR => binary_995_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 73
    -- shared load operator group (0) : ptr_deref_674_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(1 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_674_load_0_req_0;
      ptr_deref_674_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_674_load_0_req_1;
      ptr_deref_674_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_674_word_address_0;
      ptr_deref_674_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 2,  num_reqs => 1,  tag_length => 1, min_clock_period => true,
        no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_3_lr_req(0),
          mack => memory_space_3_lr_ack(0),
          maddr => memory_space_3_lr_addr(1 downto 0),
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
    end Block; -- load group 0
    -- shared load operator group (1) : simple_obj_ref_625_load_0 simple_obj_ref_905_load_0 
    LoadGroup1: Block -- 
      signal data_in: std_logic_vector(1 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= simple_obj_ref_625_load_0_req_0;
      reqL(0) <= simple_obj_ref_905_load_0_req_0;
      simple_obj_ref_625_load_0_ack_0 <= ackL(1);
      simple_obj_ref_905_load_0_ack_0 <= ackL(0);
      reqR(1) <= simple_obj_ref_625_load_0_req_1;
      reqR(0) <= simple_obj_ref_905_load_0_req_1;
      simple_obj_ref_625_load_0_ack_1 <= ackR(1);
      simple_obj_ref_905_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_625_word_address_0 & simple_obj_ref_905_word_address_0;
      simple_obj_ref_625_data_0 <= data_out(63 downto 32);
      simple_obj_ref_905_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 2,  tag_length => 2, min_clock_period => true,
        no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(0),
          mack => memory_space_0_lr_ack(0),
          maddr => memory_space_0_lr_addr(0 downto 0),
          mtag => memory_space_0_lr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 2,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(0),
          mack => memory_space_0_lc_ack(0),
          mdata => memory_space_0_lc_data(31 downto 0),
          mtag => memory_space_0_lc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 1
    -- shared load operator group (2) : simple_obj_ref_628_load_0 simple_obj_ref_908_load_0 
    LoadGroup2: Block -- 
      signal data_in: std_logic_vector(1 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= simple_obj_ref_628_load_0_req_0;
      reqL(0) <= simple_obj_ref_908_load_0_req_0;
      simple_obj_ref_628_load_0_ack_0 <= ackL(1);
      simple_obj_ref_908_load_0_ack_0 <= ackL(0);
      reqR(1) <= simple_obj_ref_628_load_0_req_1;
      reqR(0) <= simple_obj_ref_908_load_0_req_1;
      simple_obj_ref_628_load_0_ack_1 <= ackR(1);
      simple_obj_ref_908_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_628_word_address_0 & simple_obj_ref_908_word_address_0;
      simple_obj_ref_628_data_0 <= data_out(63 downto 32);
      simple_obj_ref_908_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 2,  tag_length => 2, min_clock_period => true,
        no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_1_lr_req(0),
          mack => memory_space_1_lr_ack(0),
          maddr => memory_space_1_lr_addr(0 downto 0),
          mtag => memory_space_1_lr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 2,  tag_length => 2,  no_arbitration => true)
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
    end Block; -- load group 2
    -- shared load operator group (3) : simple_obj_ref_631_load_0 simple_obj_ref_911_load_0 
    LoadGroup3: Block -- 
      signal data_in: std_logic_vector(1 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= simple_obj_ref_631_load_0_req_0;
      reqL(0) <= simple_obj_ref_911_load_0_req_0;
      simple_obj_ref_631_load_0_ack_0 <= ackL(1);
      simple_obj_ref_911_load_0_ack_0 <= ackL(0);
      reqR(1) <= simple_obj_ref_631_load_0_req_1;
      reqR(0) <= simple_obj_ref_911_load_0_req_1;
      simple_obj_ref_631_load_0_ack_1 <= ackR(1);
      simple_obj_ref_911_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_631_word_address_0 & simple_obj_ref_911_word_address_0;
      simple_obj_ref_631_data_0 <= data_out(63 downto 32);
      simple_obj_ref_911_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 2,  tag_length => 2, min_clock_period => true,
        no_arbitration => true)
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
    end Block; -- load group 3
    -- shared load operator group (4) : simple_obj_ref_902_load_0 
    LoadGroup4: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_902_load_0_req_0;
      simple_obj_ref_902_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_902_load_0_req_1;
      simple_obj_ref_902_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_902_word_address_0;
      simple_obj_ref_902_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 1, min_clock_period => true,
        no_arbitration => true)
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
    -- shared store operator group (0) : simple_obj_ref_892_store_0 simple_obj_ref_1150_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(1 downto 0);
      signal data_in: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= simple_obj_ref_892_store_0_req_0;
      reqL(0) <= simple_obj_ref_1150_store_0_req_0;
      simple_obj_ref_892_store_0_ack_0 <= ackL(1);
      simple_obj_ref_1150_store_0_ack_0 <= ackL(0);
      reqR(1) <= simple_obj_ref_892_store_0_req_1;
      reqR(0) <= simple_obj_ref_1150_store_0_req_1;
      simple_obj_ref_892_store_0_ack_1 <= ackR(1);
      simple_obj_ref_1150_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_892_word_address_0 & simple_obj_ref_1150_word_address_0;
      data_in <= simple_obj_ref_892_data_0 & simple_obj_ref_1150_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 2,
        tag_length => 2,
        min_clock_period => true,
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
          num_reqs => 2,
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
    end Block; -- store group 0
    -- shared store operator group (1) : simple_obj_ref_895_store_0 simple_obj_ref_1153_store_0 
    StoreGroup1: Block -- 
      signal addr_in: std_logic_vector(1 downto 0);
      signal data_in: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= simple_obj_ref_895_store_0_req_0;
      reqL(0) <= simple_obj_ref_1153_store_0_req_0;
      simple_obj_ref_895_store_0_ack_0 <= ackL(1);
      simple_obj_ref_1153_store_0_ack_0 <= ackL(0);
      reqR(1) <= simple_obj_ref_895_store_0_req_1;
      reqR(0) <= simple_obj_ref_1153_store_0_req_1;
      simple_obj_ref_895_store_0_ack_1 <= ackR(1);
      simple_obj_ref_1153_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_895_word_address_0 & simple_obj_ref_1153_word_address_0;
      data_in <= simple_obj_ref_895_data_0 & simple_obj_ref_1153_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 2,
        tag_length => 2,
        min_clock_period => true,
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
          mtag => memory_space_1_sr_tag(1 downto 0),
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
          mreq => memory_space_1_sc_req(0),
          mack => memory_space_1_sc_ack(0),
          mtag => memory_space_1_sc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 1
    -- shared store operator group (2) : simple_obj_ref_898_store_0 simple_obj_ref_1156_store_0 
    StoreGroup2: Block -- 
      signal addr_in: std_logic_vector(1 downto 0);
      signal data_in: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= simple_obj_ref_898_store_0_req_0;
      reqL(0) <= simple_obj_ref_1156_store_0_req_0;
      simple_obj_ref_898_store_0_ack_0 <= ackL(1);
      simple_obj_ref_1156_store_0_ack_0 <= ackL(0);
      reqR(1) <= simple_obj_ref_898_store_0_req_1;
      reqR(0) <= simple_obj_ref_1156_store_0_req_1;
      simple_obj_ref_898_store_0_ack_1 <= ackR(1);
      simple_obj_ref_1156_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_898_word_address_0 & simple_obj_ref_1156_word_address_0;
      data_in <= simple_obj_ref_898_data_0 & simple_obj_ref_1156_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 2,
        tag_length => 2,
        min_clock_period => true,
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
    end Block; -- store group 2
    -- shared call operator group (0) : call_stmt_1170_call 
    CallGroup0: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= call_stmt_1170_call_req_0;
      call_stmt_1170_call_ack_0 <= ackL(0);
      reqR(0) <= call_stmt_1170_call_req_1;
      call_stmt_1170_call_ack_1 <= ackR(0);
      iNsTr_90_1170 <= data_out(31 downto 0);
      CallReq: InputMuxBaseNoData -- 
        generic map (  twidth => 1, nreqs => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          reqR => a5reg_call_reqs(0),
          ackR => a5reg_call_acks(0),
          tagR => a5reg_call_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      CallComplete: OutputDemuxBase -- 
        generic map ( 
        iwidth => 32, owidth => 32, twidth => 1, nreqs => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          reqL => a5reg_return_acks(0), -- cross-over
          ackL => a5reg_return_reqs(0), -- cross-over
          dataL => a5reg_return_data(31 downto 0),
          tagL => a5reg_return_tag(0 downto 0),
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
entity a5reg is -- 
  generic (tag_length : integer); 
  port ( -- 
    ret_val_x_x : out  std_logic_vector(31 downto 0);
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic;
    memory_space_2_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_2_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_lr_addr : out  std_logic_vector(0 downto 0);
    memory_space_2_lr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_2_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_2_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_2_lc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_0_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_0_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_lr_addr : out  std_logic_vector(0 downto 0);
    memory_space_0_lr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_0_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_0_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_0_lc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_1_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_1_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_lr_addr : out  std_logic_vector(0 downto 0);
    memory_space_1_lr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_1_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_1_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_1_lc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_2_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_2_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_sr_addr : out  std_logic_vector(0 downto 0);
    memory_space_2_sr_data : out  std_logic_vector(31 downto 0);
    memory_space_2_sr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_2_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_2_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_sc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_0_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_0_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_sr_addr : out  std_logic_vector(0 downto 0);
    memory_space_0_sr_data : out  std_logic_vector(31 downto 0);
    memory_space_0_sr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_0_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_0_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_sc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_1_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_1_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_sr_addr : out  std_logic_vector(0 downto 0);
    memory_space_1_sr_data : out  std_logic_vector(31 downto 0);
    memory_space_1_sr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_1_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_1_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_sc_tag :  in  std_logic_vector(1 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
  );
  -- 
end entity a5reg;
architecture Default of a5reg is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal start_req_symbol: Boolean;
  signal start_ack_symbol: Boolean;
  signal fin_req_symbol: Boolean;
  signal fin_ack_symbol: Boolean;
  signal tag_push, tag_pop: std_logic; 
  signal start_ack_sig, fin_ack_sig: std_logic; 
  -- output port buffer signals
  signal ret_val_x_x_buffer :  std_logic_vector(31 downto 0);
  signal a5reg_CP_0_start: Boolean;
  -- links between control-path and data-path
  signal simple_obj_ref_18_load_0_req_0 : boolean;
  signal simple_obj_ref_18_load_0_ack_0 : boolean;
  signal simple_obj_ref_18_load_0_req_1 : boolean;
  signal simple_obj_ref_18_load_0_ack_1 : boolean;
  signal simple_obj_ref_18_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_18_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_15_load_0_req_0 : boolean;
  signal simple_obj_ref_15_load_0_ack_0 : boolean;
  signal simple_obj_ref_15_load_0_req_1 : boolean;
  signal simple_obj_ref_15_load_0_ack_1 : boolean;
  signal simple_obj_ref_15_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_15_gather_scatter_ack_0 : boolean;
  signal binary_57_inst_req_1 : boolean;
  signal binary_57_inst_ack_1 : boolean;
  signal simple_obj_ref_21_load_0_req_0 : boolean;
  signal simple_obj_ref_21_load_0_ack_0 : boolean;
  signal simple_obj_ref_21_load_0_req_1 : boolean;
  signal simple_obj_ref_21_load_0_ack_1 : boolean;
  signal simple_obj_ref_21_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_21_gather_scatter_ack_0 : boolean;
  signal binary_27_inst_req_0 : boolean;
  signal binary_27_inst_ack_0 : boolean;
  signal binary_27_inst_req_1 : boolean;
  signal binary_27_inst_ack_1 : boolean;
  signal binary_33_inst_req_0 : boolean;
  signal binary_33_inst_ack_0 : boolean;
  signal binary_33_inst_req_1 : boolean;
  signal binary_33_inst_ack_1 : boolean;
  signal binary_39_inst_req_0 : boolean;
  signal binary_39_inst_ack_0 : boolean;
  signal binary_39_inst_req_1 : boolean;
  signal binary_39_inst_ack_1 : boolean;
  signal binary_45_inst_req_0 : boolean;
  signal binary_45_inst_ack_0 : boolean;
  signal binary_45_inst_req_1 : boolean;
  signal binary_45_inst_ack_1 : boolean;
  signal binary_51_inst_req_0 : boolean;
  signal binary_51_inst_ack_0 : boolean;
  signal binary_51_inst_req_1 : boolean;
  signal binary_51_inst_ack_1 : boolean;
  signal binary_57_inst_req_0 : boolean;
  signal binary_57_inst_ack_0 : boolean;
  signal binary_128_inst_req_0 : boolean;
  signal binary_128_inst_ack_0 : boolean;
  signal binary_128_inst_req_1 : boolean;
  signal binary_128_inst_ack_1 : boolean;
  signal binary_63_inst_req_0 : boolean;
  signal binary_63_inst_ack_0 : boolean;
  signal binary_63_inst_req_1 : boolean;
  signal simple_obj_ref_427_store_0_ack_1 : boolean;
  signal binary_63_inst_ack_1 : boolean;
  signal binary_69_inst_req_0 : boolean;
  signal binary_69_inst_ack_0 : boolean;
  signal binary_69_inst_req_1 : boolean;
  signal simple_obj_ref_427_store_0_req_1 : boolean;
  signal binary_69_inst_ack_1 : boolean;
  signal binary_75_inst_req_0 : boolean;
  signal binary_75_inst_ack_0 : boolean;
  signal binary_75_inst_req_1 : boolean;
  signal binary_75_inst_ack_1 : boolean;
  signal binary_81_inst_req_0 : boolean;
  signal binary_81_inst_ack_0 : boolean;
  signal binary_81_inst_req_1 : boolean;
  signal binary_81_inst_ack_1 : boolean;
  signal binary_87_inst_req_0 : boolean;
  signal binary_87_inst_ack_0 : boolean;
  signal binary_87_inst_req_1 : boolean;
  signal binary_87_inst_ack_1 : boolean;
  signal binary_92_inst_req_0 : boolean;
  signal binary_92_inst_ack_0 : boolean;
  signal binary_92_inst_req_1 : boolean;
  signal binary_92_inst_ack_1 : boolean;
  signal binary_98_inst_req_0 : boolean;
  signal binary_98_inst_ack_0 : boolean;
  signal binary_98_inst_req_1 : boolean;
  signal binary_98_inst_ack_1 : boolean;
  signal binary_103_inst_req_0 : boolean;
  signal binary_103_inst_ack_0 : boolean;
  signal binary_103_inst_req_1 : boolean;
  signal binary_103_inst_ack_1 : boolean;
  signal binary_108_inst_req_0 : boolean;
  signal binary_108_inst_ack_0 : boolean;
  signal binary_108_inst_req_1 : boolean;
  signal simple_obj_ref_427_store_0_ack_0 : boolean;
  signal binary_108_inst_ack_1 : boolean;
  signal binary_113_inst_req_0 : boolean;
  signal binary_113_inst_ack_0 : boolean;
  signal binary_113_inst_req_1 : boolean;
  signal simple_obj_ref_427_store_0_req_0 : boolean;
  signal binary_113_inst_ack_1 : boolean;
  signal binary_118_inst_req_0 : boolean;
  signal binary_118_inst_ack_0 : boolean;
  signal binary_118_inst_req_1 : boolean;
  signal binary_118_inst_ack_1 : boolean;
  signal binary_123_inst_req_0 : boolean;
  signal binary_123_inst_ack_0 : boolean;
  signal binary_123_inst_req_1 : boolean;
  signal binary_123_inst_ack_1 : boolean;
  signal binary_272_inst_ack_0 : boolean;
  signal binary_272_inst_req_1 : boolean;
  signal binary_272_inst_ack_1 : boolean;
  signal binary_278_inst_req_0 : boolean;
  signal binary_278_inst_ack_0 : boolean;
  signal binary_278_inst_req_1 : boolean;
  signal binary_278_inst_ack_1 : boolean;
  signal binary_284_inst_req_0 : boolean;
  signal binary_284_inst_ack_0 : boolean;
  signal binary_133_inst_req_0 : boolean;
  signal binary_133_inst_ack_0 : boolean;
  signal binary_133_inst_req_1 : boolean;
  signal binary_133_inst_ack_1 : boolean;
  signal binary_138_inst_req_0 : boolean;
  signal binary_138_inst_ack_0 : boolean;
  signal binary_138_inst_req_1 : boolean;
  signal simple_obj_ref_427_gather_scatter_ack_0 : boolean;
  signal binary_138_inst_ack_1 : boolean;
  signal binary_143_inst_req_0 : boolean;
  signal binary_143_inst_ack_0 : boolean;
  signal binary_143_inst_req_1 : boolean;
  signal simple_obj_ref_427_gather_scatter_req_0 : boolean;
  signal binary_143_inst_ack_1 : boolean;
  signal binary_148_inst_req_0 : boolean;
  signal binary_148_inst_ack_0 : boolean;
  signal binary_148_inst_req_1 : boolean;
  signal binary_148_inst_ack_1 : boolean;
  signal binary_153_inst_req_0 : boolean;
  signal binary_153_inst_ack_0 : boolean;
  signal binary_153_inst_req_1 : boolean;
  signal binary_153_inst_ack_1 : boolean;
  signal binary_158_inst_req_0 : boolean;
  signal binary_158_inst_ack_0 : boolean;
  signal binary_158_inst_req_1 : boolean;
  signal binary_158_inst_ack_1 : boolean;
  signal binary_164_inst_req_0 : boolean;
  signal binary_164_inst_ack_0 : boolean;
  signal binary_164_inst_req_1 : boolean;
  signal binary_164_inst_ack_1 : boolean;
  signal binary_170_inst_req_0 : boolean;
  signal binary_170_inst_ack_0 : boolean;
  signal binary_170_inst_req_1 : boolean;
  signal binary_170_inst_ack_1 : boolean;
  signal binary_176_inst_req_0 : boolean;
  signal binary_176_inst_ack_0 : boolean;
  signal binary_176_inst_req_1 : boolean;
  signal binary_176_inst_ack_1 : boolean;
  signal binary_182_inst_req_0 : boolean;
  signal binary_182_inst_ack_0 : boolean;
  signal binary_182_inst_req_1 : boolean;
  signal binary_182_inst_ack_1 : boolean;
  signal binary_187_inst_req_0 : boolean;
  signal binary_187_inst_ack_0 : boolean;
  signal binary_187_inst_req_1 : boolean;
  signal binary_187_inst_ack_1 : boolean;
  signal binary_192_inst_req_0 : boolean;
  signal binary_192_inst_ack_0 : boolean;
  signal binary_192_inst_req_1 : boolean;
  signal binary_192_inst_ack_1 : boolean;
  signal binary_197_inst_req_0 : boolean;
  signal binary_197_inst_ack_0 : boolean;
  signal binary_197_inst_req_1 : boolean;
  signal binary_197_inst_ack_1 : boolean;
  signal binary_203_inst_req_0 : boolean;
  signal binary_203_inst_ack_0 : boolean;
  signal binary_203_inst_req_1 : boolean;
  signal binary_203_inst_ack_1 : boolean;
  signal binary_209_inst_req_0 : boolean;
  signal binary_209_inst_ack_0 : boolean;
  signal binary_209_inst_req_1 : boolean;
  signal binary_209_inst_ack_1 : boolean;
  signal binary_215_inst_req_0 : boolean;
  signal binary_215_inst_ack_0 : boolean;
  signal binary_215_inst_req_1 : boolean;
  signal binary_215_inst_ack_1 : boolean;
  signal binary_220_inst_req_0 : boolean;
  signal binary_220_inst_ack_0 : boolean;
  signal binary_220_inst_req_1 : boolean;
  signal binary_220_inst_ack_1 : boolean;
  signal binary_226_inst_req_0 : boolean;
  signal binary_226_inst_ack_0 : boolean;
  signal binary_226_inst_req_1 : boolean;
  signal binary_226_inst_ack_1 : boolean;
  signal binary_232_inst_req_0 : boolean;
  signal binary_232_inst_ack_0 : boolean;
  signal binary_232_inst_req_1 : boolean;
  signal binary_232_inst_ack_1 : boolean;
  signal binary_237_inst_req_0 : boolean;
  signal binary_237_inst_ack_0 : boolean;
  signal binary_237_inst_req_1 : boolean;
  signal binary_237_inst_ack_1 : boolean;
  signal binary_243_inst_req_0 : boolean;
  signal binary_243_inst_ack_0 : boolean;
  signal binary_243_inst_req_1 : boolean;
  signal binary_243_inst_ack_1 : boolean;
  signal binary_249_inst_req_0 : boolean;
  signal binary_249_inst_ack_0 : boolean;
  signal binary_249_inst_req_1 : boolean;
  signal binary_249_inst_ack_1 : boolean;
  signal binary_255_inst_req_0 : boolean;
  signal binary_255_inst_ack_0 : boolean;
  signal binary_255_inst_req_1 : boolean;
  signal binary_255_inst_ack_1 : boolean;
  signal binary_260_inst_req_0 : boolean;
  signal binary_260_inst_ack_0 : boolean;
  signal binary_260_inst_req_1 : boolean;
  signal binary_260_inst_ack_1 : boolean;
  signal binary_266_inst_req_0 : boolean;
  signal binary_266_inst_ack_0 : boolean;
  signal binary_266_inst_req_1 : boolean;
  signal binary_266_inst_ack_1 : boolean;
  signal binary_272_inst_req_0 : boolean;
  signal binary_284_inst_req_1 : boolean;
  signal binary_284_inst_ack_1 : boolean;
  signal binary_289_inst_req_0 : boolean;
  signal binary_289_inst_ack_0 : boolean;
  signal binary_289_inst_req_1 : boolean;
  signal binary_289_inst_ack_1 : boolean;
  signal binary_294_inst_req_0 : boolean;
  signal binary_294_inst_ack_0 : boolean;
  signal binary_294_inst_req_1 : boolean;
  signal binary_294_inst_ack_1 : boolean;
  signal binary_299_inst_req_0 : boolean;
  signal binary_299_inst_ack_0 : boolean;
  signal binary_299_inst_req_1 : boolean;
  signal binary_299_inst_ack_1 : boolean;
  signal binary_305_inst_req_0 : boolean;
  signal binary_305_inst_ack_0 : boolean;
  signal binary_305_inst_req_1 : boolean;
  signal binary_305_inst_ack_1 : boolean;
  signal binary_311_inst_req_0 : boolean;
  signal binary_311_inst_ack_0 : boolean;
  signal binary_311_inst_req_1 : boolean;
  signal binary_311_inst_ack_1 : boolean;
  signal binary_317_inst_req_0 : boolean;
  signal binary_317_inst_ack_0 : boolean;
  signal binary_317_inst_req_1 : boolean;
  signal binary_317_inst_ack_1 : boolean;
  signal binary_322_inst_req_0 : boolean;
  signal binary_322_inst_ack_0 : boolean;
  signal binary_322_inst_req_1 : boolean;
  signal binary_322_inst_ack_1 : boolean;
  signal binary_327_inst_req_0 : boolean;
  signal binary_327_inst_ack_0 : boolean;
  signal binary_327_inst_req_1 : boolean;
  signal binary_327_inst_ack_1 : boolean;
  signal binary_333_inst_req_0 : boolean;
  signal binary_333_inst_ack_0 : boolean;
  signal binary_333_inst_req_1 : boolean;
  signal binary_333_inst_ack_1 : boolean;
  signal binary_338_inst_req_0 : boolean;
  signal binary_338_inst_ack_0 : boolean;
  signal binary_338_inst_req_1 : boolean;
  signal binary_338_inst_ack_1 : boolean;
  signal binary_343_inst_req_0 : boolean;
  signal binary_343_inst_ack_0 : boolean;
  signal binary_343_inst_req_1 : boolean;
  signal binary_343_inst_ack_1 : boolean;
  signal binary_348_inst_req_0 : boolean;
  signal binary_348_inst_ack_0 : boolean;
  signal binary_348_inst_req_1 : boolean;
  signal binary_348_inst_ack_1 : boolean;
  signal binary_354_inst_req_0 : boolean;
  signal binary_354_inst_ack_0 : boolean;
  signal binary_354_inst_req_1 : boolean;
  signal binary_354_inst_ack_1 : boolean;
  signal binary_359_inst_req_0 : boolean;
  signal binary_359_inst_ack_0 : boolean;
  signal binary_359_inst_req_1 : boolean;
  signal binary_359_inst_ack_1 : boolean;
  signal binary_364_inst_req_0 : boolean;
  signal binary_364_inst_ack_0 : boolean;
  signal binary_364_inst_req_1 : boolean;
  signal binary_364_inst_ack_1 : boolean;
  signal binary_369_inst_req_0 : boolean;
  signal binary_369_inst_ack_0 : boolean;
  signal binary_369_inst_req_1 : boolean;
  signal binary_369_inst_ack_1 : boolean;
  signal binary_375_inst_req_0 : boolean;
  signal binary_375_inst_ack_0 : boolean;
  signal binary_375_inst_req_1 : boolean;
  signal binary_375_inst_ack_1 : boolean;
  signal binary_380_inst_req_0 : boolean;
  signal binary_380_inst_ack_0 : boolean;
  signal binary_380_inst_req_1 : boolean;
  signal binary_380_inst_ack_1 : boolean;
  signal binary_385_inst_req_0 : boolean;
  signal binary_385_inst_ack_0 : boolean;
  signal binary_385_inst_req_1 : boolean;
  signal binary_385_inst_ack_1 : boolean;
  signal binary_391_inst_req_0 : boolean;
  signal binary_391_inst_ack_0 : boolean;
  signal binary_391_inst_req_1 : boolean;
  signal binary_391_inst_ack_1 : boolean;
  signal binary_397_inst_req_0 : boolean;
  signal binary_397_inst_ack_0 : boolean;
  signal binary_397_inst_req_1 : boolean;
  signal binary_397_inst_ack_1 : boolean;
  signal binary_403_inst_req_0 : boolean;
  signal binary_403_inst_ack_0 : boolean;
  signal binary_403_inst_req_1 : boolean;
  signal binary_403_inst_ack_1 : boolean;
  signal binary_408_inst_req_0 : boolean;
  signal binary_408_inst_ack_0 : boolean;
  signal binary_408_inst_req_1 : boolean;
  signal binary_408_inst_ack_1 : boolean;
  signal binary_413_inst_req_0 : boolean;
  signal binary_413_inst_ack_0 : boolean;
  signal binary_413_inst_req_1 : boolean;
  signal binary_413_inst_ack_1 : boolean;
  signal binary_419_inst_req_0 : boolean;
  signal binary_419_inst_ack_0 : boolean;
  signal binary_419_inst_req_1 : boolean;
  signal binary_419_inst_ack_1 : boolean;
  signal simple_obj_ref_421_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_421_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_421_store_0_req_0 : boolean;
  signal simple_obj_ref_421_store_0_ack_0 : boolean;
  signal simple_obj_ref_421_store_0_req_1 : boolean;
  signal simple_obj_ref_421_store_0_ack_1 : boolean;
  signal simple_obj_ref_424_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_424_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_424_store_0_req_0 : boolean;
  signal simple_obj_ref_424_store_0_ack_0 : boolean;
  signal simple_obj_ref_424_store_0_req_1 : boolean;
  signal simple_obj_ref_424_store_0_ack_1 : boolean;
  -- 
begin --  
  -- output port buffering assignments
  ret_val_x_x <= ret_val_x_x_buffer; 
  -- level-to-pulse translation..
  l2pStart: level_to_pulse -- 
    port map(clk => clk, reset =>reset, lreq => start_req, lack => start_ack_sig, preq => start_req_symbol, pack => start_ack_symbol); -- 
  start_ack <= start_ack_sig; 
  l2pFin: level_to_pulse -- 
    port map(clk => clk, reset =>reset, lreq => fin_req, lack => fin_ack_sig, preq => fin_req_symbol, pack => fin_ack_symbol); -- 
  fin_ack <= fin_ack_sig; 
  tag_push <= '1' when start_req_symbol else '0'; 
  tag_pop  <= fin_req and fin_ack_sig ; 
  tagQueue: QueueBase generic map(data_width => 2, queue_depth => 1 + 1) -- 
    port map(pop_req => tag_pop, pop_ack => open, 
    push_req => tag_push, push_ack => open, 
    data_out => tag_out, data_in => tag_in, 
    clk => clk, reset => reset); -- 
  -- the control path
  always_true_symbol <= true; 
  a5reg_CP_0: Block -- control-path 
    signal cp_elements: BooleanArray(376 downto 0);
    -- 
  begin -- 
    cp_elements(0) <= start_req_symbol;
    start_ack_symbol <= cp_elements(1);
    finAckJoin: join2 port map(pred0 => fin_req_symbol, pred1 => cp_elements(1), symbol_out => fin_ack_symbol, clk => clk, reset => reset);
    cp_elements(1) <= cp_elements(376);
    cp_elements(2) <= cp_elements(0);
    cp_elements(3) <= cp_elements(2);
    simple_obj_ref_15_load_0_req_0 <= cp_elements(3);
    cp_elements(4) <= simple_obj_ref_15_load_0_ack_0;
    cp_elements(5) <= cp_elements(4);
    simple_obj_ref_15_load_0_req_1 <= cp_elements(5);
    cp_elements(6) <= simple_obj_ref_15_load_0_ack_1;
    simple_obj_ref_15_gather_scatter_req_0 <= cp_elements(6);
    cp_elements(7) <= simple_obj_ref_15_gather_scatter_ack_0;
    cp_elements(8) <= cp_elements(2);
    simple_obj_ref_18_load_0_req_0 <= cp_elements(8);
    cp_elements(9) <= simple_obj_ref_18_load_0_ack_0;
    cp_elements(10) <= cp_elements(9);
    simple_obj_ref_18_load_0_req_1 <= cp_elements(10);
    cp_elements(11) <= simple_obj_ref_18_load_0_ack_1;
    simple_obj_ref_18_gather_scatter_req_0 <= cp_elements(11);
    cp_elements(12) <= simple_obj_ref_18_gather_scatter_ack_0;
    cp_elements(13) <= cp_elements(2);
    simple_obj_ref_21_load_0_req_0 <= cp_elements(13);
    cp_elements(14) <= simple_obj_ref_21_load_0_ack_0;
    cp_elements(15) <= cp_elements(14);
    simple_obj_ref_21_load_0_req_1 <= cp_elements(15);
    cp_elements(16) <= simple_obj_ref_21_load_0_ack_1;
    simple_obj_ref_21_gather_scatter_req_0 <= cp_elements(16);
    cp_elements(17) <= simple_obj_ref_21_gather_scatter_ack_0;
    cpelement_group_18 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(19) & cp_elements(20));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(18),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_27_inst_req_0 <= cp_elements(18);
    cp_elements(19) <= cp_elements(2);
    cp_elements(20) <= cp_elements(7);
    cp_elements(21) <= binary_27_inst_ack_0;
    binary_27_inst_req_1 <= cp_elements(21);
    cp_elements(22) <= binary_27_inst_ack_1;
    cpelement_group_23 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(24) & cp_elements(25));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(23),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_33_inst_req_0 <= cp_elements(23);
    cp_elements(24) <= cp_elements(2);
    cp_elements(25) <= cp_elements(12);
    cp_elements(26) <= binary_33_inst_ack_0;
    binary_33_inst_req_1 <= cp_elements(26);
    cp_elements(27) <= binary_33_inst_ack_1;
    cpelement_group_28 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(29) & cp_elements(30));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(28),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_39_inst_req_0 <= cp_elements(28);
    cp_elements(29) <= cp_elements(2);
    cp_elements(30) <= cp_elements(17);
    cp_elements(31) <= binary_39_inst_ack_0;
    binary_39_inst_req_1 <= cp_elements(31);
    cp_elements(32) <= binary_39_inst_ack_1;
    cpelement_group_33 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(22) & cp_elements(34));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(33),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_45_inst_req_0 <= cp_elements(33);
    cp_elements(34) <= cp_elements(2);
    cp_elements(35) <= binary_45_inst_ack_0;
    binary_45_inst_req_1 <= cp_elements(35);
    cp_elements(36) <= binary_45_inst_ack_1;
    cpelement_group_37 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(38) & cp_elements(39));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(37),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_51_inst_req_0 <= cp_elements(37);
    cp_elements(38) <= cp_elements(2);
    cp_elements(39) <= cp_elements(36);
    cp_elements(40) <= binary_51_inst_ack_0;
    binary_51_inst_req_1 <= cp_elements(40);
    cp_elements(41) <= binary_51_inst_ack_1;
    cpelement_group_42 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(27) & cp_elements(43));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(42),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_57_inst_req_0 <= cp_elements(42);
    cp_elements(43) <= cp_elements(2);
    cp_elements(44) <= binary_57_inst_ack_0;
    binary_57_inst_req_1 <= cp_elements(44);
    cp_elements(45) <= binary_57_inst_ack_1;
    cpelement_group_46 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(47) & cp_elements(48));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(46),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_63_inst_req_0 <= cp_elements(46);
    cp_elements(47) <= cp_elements(2);
    cp_elements(48) <= cp_elements(45);
    cp_elements(49) <= binary_63_inst_ack_0;
    binary_63_inst_req_1 <= cp_elements(49);
    cp_elements(50) <= binary_63_inst_ack_1;
    cpelement_group_51 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(32) & cp_elements(52));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(51),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_69_inst_req_0 <= cp_elements(51);
    cp_elements(52) <= cp_elements(2);
    cp_elements(53) <= binary_69_inst_ack_0;
    binary_69_inst_req_1 <= cp_elements(53);
    cp_elements(54) <= binary_69_inst_ack_1;
    cpelement_group_55 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(56) & cp_elements(57));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(55),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_75_inst_req_0 <= cp_elements(55);
    cp_elements(56) <= cp_elements(2);
    cp_elements(57) <= cp_elements(54);
    cp_elements(58) <= binary_75_inst_ack_0;
    binary_75_inst_req_1 <= cp_elements(58);
    cp_elements(59) <= binary_75_inst_ack_1;
    cpelement_group_60 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(61) & cp_elements(62));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(60),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_81_inst_req_0 <= cp_elements(60);
    cp_elements(61) <= cp_elements(2);
    cp_elements(62) <= cp_elements(45);
    cp_elements(63) <= binary_81_inst_ack_0;
    binary_81_inst_req_1 <= cp_elements(63);
    cp_elements(64) <= binary_81_inst_ack_1;
    cpelement_group_65 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(66) & cp_elements(67));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(65),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_87_inst_req_0 <= cp_elements(65);
    cp_elements(66) <= cp_elements(2);
    cp_elements(67) <= cp_elements(54);
    cp_elements(68) <= binary_87_inst_ack_0;
    binary_87_inst_req_1 <= cp_elements(68);
    cp_elements(69) <= binary_87_inst_ack_1;
    cpelement_group_70 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(71) & cp_elements(72) & cp_elements(73));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(70),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_92_inst_req_0 <= cp_elements(70);
    cp_elements(71) <= cp_elements(2);
    cp_elements(72) <= cp_elements(69);
    cp_elements(73) <= cp_elements(64);
    cp_elements(74) <= binary_92_inst_ack_0;
    binary_92_inst_req_1 <= cp_elements(74);
    cp_elements(75) <= binary_92_inst_ack_1;
    cpelement_group_76 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(77) & cp_elements(78));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(76),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_98_inst_req_0 <= cp_elements(76);
    cp_elements(77) <= cp_elements(2);
    cp_elements(78) <= cp_elements(36);
    cp_elements(79) <= binary_98_inst_ack_0;
    binary_98_inst_req_1 <= cp_elements(79);
    cp_elements(80) <= binary_98_inst_ack_1;
    cpelement_group_81 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(82) & cp_elements(83) & cp_elements(84));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(81),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_103_inst_req_0 <= cp_elements(81);
    cp_elements(82) <= cp_elements(2);
    cp_elements(83) <= cp_elements(80);
    cp_elements(84) <= cp_elements(59);
    cp_elements(85) <= binary_103_inst_ack_0;
    binary_103_inst_req_1 <= cp_elements(85);
    cp_elements(86) <= binary_103_inst_ack_1;
    cpelement_group_87 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(88) & cp_elements(89) & cp_elements(90));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(87),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_108_inst_req_0 <= cp_elements(87);
    cp_elements(88) <= cp_elements(2);
    cp_elements(89) <= cp_elements(50);
    cp_elements(90) <= cp_elements(41);
    cp_elements(91) <= binary_108_inst_ack_0;
    binary_108_inst_req_1 <= cp_elements(91);
    cp_elements(92) <= binary_108_inst_ack_1;
    cpelement_group_93 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(86) & cp_elements(94) & cp_elements(95));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(93),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_113_inst_req_0 <= cp_elements(93);
    cp_elements(94) <= cp_elements(2);
    cp_elements(95) <= cp_elements(92);
    cp_elements(96) <= binary_113_inst_ack_0;
    binary_113_inst_req_1 <= cp_elements(96);
    cp_elements(97) <= binary_113_inst_ack_1;
    cpelement_group_98 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(97) & cp_elements(99) & cp_elements(100));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(98),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_118_inst_req_0 <= cp_elements(98);
    cp_elements(99) <= cp_elements(2);
    cp_elements(100) <= cp_elements(75);
    cp_elements(101) <= binary_118_inst_ack_0;
    binary_118_inst_req_1 <= cp_elements(101);
    cp_elements(102) <= binary_118_inst_ack_1;
    cpelement_group_103 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(104) & cp_elements(105) & cp_elements(106));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(103),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_123_inst_req_0 <= cp_elements(103);
    cp_elements(104) <= cp_elements(2);
    cp_elements(105) <= cp_elements(80);
    cp_elements(106) <= cp_elements(50);
    cp_elements(107) <= binary_123_inst_ack_0;
    binary_123_inst_req_1 <= cp_elements(107);
    cp_elements(108) <= binary_123_inst_ack_1;
    cpelement_group_109 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(110) & cp_elements(111) & cp_elements(112));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(109),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_128_inst_req_0 <= cp_elements(109);
    cp_elements(110) <= cp_elements(2);
    cp_elements(111) <= cp_elements(59);
    cp_elements(112) <= cp_elements(41);
    cp_elements(113) <= binary_128_inst_ack_0;
    binary_128_inst_req_1 <= cp_elements(113);
    cp_elements(114) <= binary_128_inst_ack_1;
    cpelement_group_115 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(108) & cp_elements(114) & cp_elements(116));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(115),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_133_inst_req_0 <= cp_elements(115);
    cp_elements(116) <= cp_elements(2);
    cp_elements(117) <= binary_133_inst_ack_0;
    binary_133_inst_req_1 <= cp_elements(117);
    cp_elements(118) <= binary_133_inst_ack_1;
    cpelement_group_119 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(118) & cp_elements(120) & cp_elements(121));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(119),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_138_inst_req_0 <= cp_elements(119);
    cp_elements(120) <= cp_elements(2);
    cp_elements(121) <= cp_elements(75);
    cp_elements(122) <= binary_138_inst_ack_0;
    binary_138_inst_req_1 <= cp_elements(122);
    cp_elements(123) <= binary_138_inst_ack_1;
    cpelement_group_124 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(125) & cp_elements(126) & cp_elements(127));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(124),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_143_inst_req_0 <= cp_elements(124);
    cp_elements(125) <= cp_elements(2);
    cp_elements(126) <= cp_elements(69);
    cp_elements(127) <= cp_elements(80);
    cp_elements(128) <= binary_143_inst_ack_0;
    binary_143_inst_req_1 <= cp_elements(128);
    cp_elements(129) <= binary_143_inst_ack_1;
    cpelement_group_130 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(131) & cp_elements(132) & cp_elements(133));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(130),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_148_inst_req_0 <= cp_elements(130);
    cp_elements(131) <= cp_elements(2);
    cp_elements(132) <= cp_elements(64);
    cp_elements(133) <= cp_elements(59);
    cp_elements(134) <= binary_148_inst_ack_0;
    binary_148_inst_req_1 <= cp_elements(134);
    cp_elements(135) <= binary_148_inst_ack_1;
    cpelement_group_136 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(135) & cp_elements(137) & cp_elements(138));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(136),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_153_inst_req_0 <= cp_elements(136);
    cp_elements(137) <= cp_elements(2);
    cp_elements(138) <= cp_elements(92);
    cp_elements(139) <= binary_153_inst_ack_0;
    binary_153_inst_req_1 <= cp_elements(139);
    cp_elements(140) <= binary_153_inst_ack_1;
    cpelement_group_141 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(129) & cp_elements(140) & cp_elements(142));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(141),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_158_inst_req_0 <= cp_elements(141);
    cp_elements(142) <= cp_elements(2);
    cp_elements(143) <= binary_158_inst_ack_0;
    binary_158_inst_req_1 <= cp_elements(143);
    cp_elements(144) <= binary_158_inst_ack_1;
    cpelement_group_145 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(146) & cp_elements(147));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(145),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_164_inst_req_0 <= cp_elements(145);
    cp_elements(146) <= cp_elements(2);
    cp_elements(147) <= cp_elements(7);
    cp_elements(148) <= binary_164_inst_ack_0;
    binary_164_inst_req_1 <= cp_elements(148);
    cp_elements(149) <= binary_164_inst_ack_1;
    cpelement_group_150 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(151) & cp_elements(152));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(150),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_170_inst_req_0 <= cp_elements(150);
    cp_elements(151) <= cp_elements(2);
    cp_elements(152) <= cp_elements(7);
    cp_elements(153) <= binary_170_inst_ack_0;
    binary_170_inst_req_1 <= cp_elements(153);
    cp_elements(154) <= binary_170_inst_ack_1;
    cpelement_group_155 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(156) & cp_elements(157));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(155),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_176_inst_req_0 <= cp_elements(155);
    cp_elements(156) <= cp_elements(2);
    cp_elements(157) <= cp_elements(7);
    cp_elements(158) <= binary_176_inst_ack_0;
    binary_176_inst_req_1 <= cp_elements(158);
    cp_elements(159) <= binary_176_inst_ack_1;
    cpelement_group_160 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(161) & cp_elements(162));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(160),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_182_inst_req_0 <= cp_elements(160);
    cp_elements(161) <= cp_elements(2);
    cp_elements(162) <= cp_elements(7);
    cp_elements(163) <= binary_182_inst_ack_0;
    binary_182_inst_req_1 <= cp_elements(163);
    cp_elements(164) <= binary_182_inst_ack_1;
    cpelement_group_165 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(159) & cp_elements(164) & cp_elements(166));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(165),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_187_inst_req_0 <= cp_elements(165);
    cp_elements(166) <= cp_elements(2);
    cp_elements(167) <= binary_187_inst_ack_0;
    binary_187_inst_req_1 <= cp_elements(167);
    cp_elements(168) <= binary_187_inst_ack_1;
    cpelement_group_169 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(154) & cp_elements(168) & cp_elements(170));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(169),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_192_inst_req_0 <= cp_elements(169);
    cp_elements(170) <= cp_elements(2);
    cp_elements(171) <= binary_192_inst_ack_0;
    binary_192_inst_req_1 <= cp_elements(171);
    cp_elements(172) <= binary_192_inst_ack_1;
    cpelement_group_173 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(149) & cp_elements(172) & cp_elements(174));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(173),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_197_inst_req_0 <= cp_elements(173);
    cp_elements(174) <= cp_elements(2);
    cp_elements(175) <= binary_197_inst_ack_0;
    binary_197_inst_req_1 <= cp_elements(175);
    cp_elements(176) <= binary_197_inst_ack_1;
    cpelement_group_177 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(176) & cp_elements(178));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(177),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_203_inst_req_0 <= cp_elements(177);
    cp_elements(178) <= cp_elements(2);
    cp_elements(179) <= binary_203_inst_ack_0;
    binary_203_inst_req_1 <= cp_elements(179);
    cp_elements(180) <= binary_203_inst_ack_1;
    cpelement_group_181 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(182) & cp_elements(183));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(181),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_209_inst_req_0 <= cp_elements(181);
    cp_elements(182) <= cp_elements(2);
    cp_elements(183) <= cp_elements(7);
    cp_elements(184) <= binary_209_inst_ack_0;
    binary_209_inst_req_1 <= cp_elements(184);
    cp_elements(185) <= binary_209_inst_ack_1;
    cpelement_group_186 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(185) & cp_elements(187));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(186),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_215_inst_req_0 <= cp_elements(186);
    cp_elements(187) <= cp_elements(2);
    cp_elements(188) <= binary_215_inst_ack_0;
    binary_215_inst_req_1 <= cp_elements(188);
    cp_elements(189) <= binary_215_inst_ack_1;
    cpelement_group_190 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(180) & cp_elements(189) & cp_elements(191));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(190),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_220_inst_req_0 <= cp_elements(190);
    cp_elements(191) <= cp_elements(2);
    cp_elements(192) <= binary_220_inst_ack_0;
    binary_220_inst_req_1 <= cp_elements(192);
    cp_elements(193) <= binary_220_inst_ack_1;
    cpelement_group_194 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(195) & cp_elements(196));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(194),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_226_inst_req_0 <= cp_elements(194);
    cp_elements(195) <= cp_elements(2);
    cp_elements(196) <= cp_elements(12);
    cp_elements(197) <= binary_226_inst_ack_0;
    binary_226_inst_req_1 <= cp_elements(197);
    cp_elements(198) <= binary_226_inst_ack_1;
    cpelement_group_199 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(200) & cp_elements(201));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(199),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_232_inst_req_0 <= cp_elements(199);
    cp_elements(200) <= cp_elements(2);
    cp_elements(201) <= cp_elements(12);
    cp_elements(202) <= binary_232_inst_ack_0;
    binary_232_inst_req_1 <= cp_elements(202);
    cp_elements(203) <= binary_232_inst_ack_1;
    cpelement_group_204 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(198) & cp_elements(203) & cp_elements(205));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(204),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_237_inst_req_0 <= cp_elements(204);
    cp_elements(205) <= cp_elements(2);
    cp_elements(206) <= binary_237_inst_ack_0;
    binary_237_inst_req_1 <= cp_elements(206);
    cp_elements(207) <= binary_237_inst_ack_1;
    cpelement_group_208 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(207) & cp_elements(209));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(208),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_243_inst_req_0 <= cp_elements(208);
    cp_elements(209) <= cp_elements(2);
    cp_elements(210) <= binary_243_inst_ack_0;
    binary_243_inst_req_1 <= cp_elements(210);
    cp_elements(211) <= binary_243_inst_ack_1;
    cpelement_group_212 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(213) & cp_elements(214));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(212),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_249_inst_req_0 <= cp_elements(212);
    cp_elements(213) <= cp_elements(2);
    cp_elements(214) <= cp_elements(12);
    cp_elements(215) <= binary_249_inst_ack_0;
    binary_249_inst_req_1 <= cp_elements(215);
    cp_elements(216) <= binary_249_inst_ack_1;
    cpelement_group_217 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(216) & cp_elements(218));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(217),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_255_inst_req_0 <= cp_elements(217);
    cp_elements(218) <= cp_elements(2);
    cp_elements(219) <= binary_255_inst_ack_0;
    binary_255_inst_req_1 <= cp_elements(219);
    cp_elements(220) <= binary_255_inst_ack_1;
    cpelement_group_221 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(211) & cp_elements(220) & cp_elements(222));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(221),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_260_inst_req_0 <= cp_elements(221);
    cp_elements(222) <= cp_elements(2);
    cp_elements(223) <= binary_260_inst_ack_0;
    binary_260_inst_req_1 <= cp_elements(223);
    cp_elements(224) <= binary_260_inst_ack_1;
    cpelement_group_225 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(226) & cp_elements(227));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(225),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_266_inst_req_0 <= cp_elements(225);
    cp_elements(226) <= cp_elements(2);
    cp_elements(227) <= cp_elements(17);
    cp_elements(228) <= binary_266_inst_ack_0;
    binary_266_inst_req_1 <= cp_elements(228);
    cp_elements(229) <= binary_266_inst_ack_1;
    cpelement_group_230 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(231) & cp_elements(232));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(230),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_272_inst_req_0 <= cp_elements(230);
    cp_elements(231) <= cp_elements(2);
    cp_elements(232) <= cp_elements(17);
    cp_elements(233) <= binary_272_inst_ack_0;
    binary_272_inst_req_1 <= cp_elements(233);
    cp_elements(234) <= binary_272_inst_ack_1;
    cpelement_group_235 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(236) & cp_elements(237));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(235),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_278_inst_req_0 <= cp_elements(235);
    cp_elements(236) <= cp_elements(2);
    cp_elements(237) <= cp_elements(17);
    cp_elements(238) <= binary_278_inst_ack_0;
    binary_278_inst_req_1 <= cp_elements(238);
    cp_elements(239) <= binary_278_inst_ack_1;
    cpelement_group_240 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(241) & cp_elements(242));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(240),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_284_inst_req_0 <= cp_elements(240);
    cp_elements(241) <= cp_elements(2);
    cp_elements(242) <= cp_elements(17);
    cp_elements(243) <= binary_284_inst_ack_0;
    binary_284_inst_req_1 <= cp_elements(243);
    cp_elements(244) <= binary_284_inst_ack_1;
    cpelement_group_245 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(239) & cp_elements(244) & cp_elements(246));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(245),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_289_inst_req_0 <= cp_elements(245);
    cp_elements(246) <= cp_elements(2);
    cp_elements(247) <= binary_289_inst_ack_0;
    binary_289_inst_req_1 <= cp_elements(247);
    cp_elements(248) <= binary_289_inst_ack_1;
    cpelement_group_249 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(234) & cp_elements(248) & cp_elements(250));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(249),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_294_inst_req_0 <= cp_elements(249);
    cp_elements(250) <= cp_elements(2);
    cp_elements(251) <= binary_294_inst_ack_0;
    binary_294_inst_req_1 <= cp_elements(251);
    cp_elements(252) <= binary_294_inst_ack_1;
    cpelement_group_253 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(229) & cp_elements(252) & cp_elements(254));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(253),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_299_inst_req_0 <= cp_elements(253);
    cp_elements(254) <= cp_elements(2);
    cp_elements(255) <= binary_299_inst_ack_0;
    binary_299_inst_req_1 <= cp_elements(255);
    cp_elements(256) <= binary_299_inst_ack_1;
    cpelement_group_257 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(256) & cp_elements(258));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(257),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_305_inst_req_0 <= cp_elements(257);
    cp_elements(258) <= cp_elements(2);
    cp_elements(259) <= binary_305_inst_ack_0;
    binary_305_inst_req_1 <= cp_elements(259);
    cp_elements(260) <= binary_305_inst_ack_1;
    cpelement_group_261 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(262) & cp_elements(263));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(261),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_311_inst_req_0 <= cp_elements(261);
    cp_elements(262) <= cp_elements(2);
    cp_elements(263) <= cp_elements(17);
    cp_elements(264) <= binary_311_inst_ack_0;
    binary_311_inst_req_1 <= cp_elements(264);
    cp_elements(265) <= binary_311_inst_ack_1;
    cpelement_group_266 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(265) & cp_elements(267));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(266),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_317_inst_req_0 <= cp_elements(266);
    cp_elements(267) <= cp_elements(2);
    cp_elements(268) <= binary_317_inst_ack_0;
    binary_317_inst_req_1 <= cp_elements(268);
    cp_elements(269) <= binary_317_inst_ack_1;
    cpelement_group_270 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(260) & cp_elements(269) & cp_elements(271));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(270),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_322_inst_req_0 <= cp_elements(270);
    cp_elements(271) <= cp_elements(2);
    cp_elements(272) <= binary_322_inst_ack_0;
    binary_322_inst_req_1 <= cp_elements(272);
    cp_elements(273) <= binary_322_inst_ack_1;
    cpelement_group_274 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(193) & cp_elements(275) & cp_elements(276));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(274),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_327_inst_req_0 <= cp_elements(274);
    cp_elements(275) <= cp_elements(2);
    cp_elements(276) <= cp_elements(144);
    cp_elements(277) <= binary_327_inst_ack_0;
    binary_327_inst_req_1 <= cp_elements(277);
    cp_elements(278) <= binary_327_inst_ack_1;
    cpelement_group_279 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(280) & cp_elements(281));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(279),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_333_inst_req_0 <= cp_elements(279);
    cp_elements(280) <= cp_elements(2);
    cp_elements(281) <= cp_elements(144);
    cp_elements(282) <= binary_333_inst_ack_0;
    binary_333_inst_req_1 <= cp_elements(282);
    cp_elements(283) <= binary_333_inst_ack_1;
    cpelement_group_284 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(283) & cp_elements(285) & cp_elements(286));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(284),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_338_inst_req_0 <= cp_elements(284);
    cp_elements(285) <= cp_elements(2);
    cp_elements(286) <= cp_elements(7);
    cp_elements(287) <= binary_338_inst_ack_0;
    binary_338_inst_req_1 <= cp_elements(287);
    cp_elements(288) <= binary_338_inst_ack_1;
    cpelement_group_289 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(278) & cp_elements(288) & cp_elements(290));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(289),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_343_inst_req_0 <= cp_elements(289);
    cp_elements(290) <= cp_elements(2);
    cp_elements(291) <= binary_343_inst_ack_0;
    binary_343_inst_req_1 <= cp_elements(291);
    cp_elements(292) <= binary_343_inst_ack_1;
    cpelement_group_293 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(224) & cp_elements(294) & cp_elements(295));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(293),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_348_inst_req_0 <= cp_elements(293);
    cp_elements(294) <= cp_elements(2);
    cp_elements(295) <= cp_elements(102);
    cp_elements(296) <= binary_348_inst_ack_0;
    binary_348_inst_req_1 <= cp_elements(296);
    cp_elements(297) <= binary_348_inst_ack_1;
    cpelement_group_298 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(299) & cp_elements(300));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(298),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_354_inst_req_0 <= cp_elements(298);
    cp_elements(299) <= cp_elements(2);
    cp_elements(300) <= cp_elements(102);
    cp_elements(301) <= binary_354_inst_ack_0;
    binary_354_inst_req_1 <= cp_elements(301);
    cp_elements(302) <= binary_354_inst_ack_1;
    cpelement_group_303 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(302) & cp_elements(304) & cp_elements(305));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(303),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_359_inst_req_0 <= cp_elements(303);
    cp_elements(304) <= cp_elements(2);
    cp_elements(305) <= cp_elements(12);
    cp_elements(306) <= binary_359_inst_ack_0;
    binary_359_inst_req_1 <= cp_elements(306);
    cp_elements(307) <= binary_359_inst_ack_1;
    cpelement_group_308 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(297) & cp_elements(307) & cp_elements(309));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(308),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_364_inst_req_0 <= cp_elements(308);
    cp_elements(309) <= cp_elements(2);
    cp_elements(310) <= binary_364_inst_ack_0;
    binary_364_inst_req_1 <= cp_elements(310);
    cp_elements(311) <= binary_364_inst_ack_1;
    cpelement_group_312 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(273) & cp_elements(313) & cp_elements(314));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(312),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_369_inst_req_0 <= cp_elements(312);
    cp_elements(313) <= cp_elements(2);
    cp_elements(314) <= cp_elements(123);
    cp_elements(315) <= binary_369_inst_ack_0;
    binary_369_inst_req_1 <= cp_elements(315);
    cp_elements(316) <= binary_369_inst_ack_1;
    cpelement_group_317 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(318) & cp_elements(319));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(317),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_375_inst_req_0 <= cp_elements(317);
    cp_elements(318) <= cp_elements(2);
    cp_elements(319) <= cp_elements(123);
    cp_elements(320) <= binary_375_inst_ack_0;
    binary_375_inst_req_1 <= cp_elements(320);
    cp_elements(321) <= binary_375_inst_ack_1;
    cpelement_group_322 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(321) & cp_elements(323) & cp_elements(324));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(322),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_380_inst_req_0 <= cp_elements(322);
    cp_elements(323) <= cp_elements(2);
    cp_elements(324) <= cp_elements(17);
    cp_elements(325) <= binary_380_inst_ack_0;
    binary_380_inst_req_1 <= cp_elements(325);
    cp_elements(326) <= binary_380_inst_ack_1;
    cpelement_group_327 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(316) & cp_elements(326) & cp_elements(328));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(327),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_385_inst_req_0 <= cp_elements(327);
    cp_elements(328) <= cp_elements(2);
    cp_elements(329) <= binary_385_inst_ack_0;
    binary_385_inst_req_1 <= cp_elements(329);
    cp_elements(330) <= binary_385_inst_ack_1;
    cpelement_group_331 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(332) & cp_elements(333));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(331),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_391_inst_req_0 <= cp_elements(331);
    cp_elements(332) <= cp_elements(2);
    cp_elements(333) <= cp_elements(292);
    cp_elements(334) <= binary_391_inst_ack_0;
    binary_391_inst_req_1 <= cp_elements(334);
    cp_elements(335) <= binary_391_inst_ack_1;
    cpelement_group_336 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(337) & cp_elements(338));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(336),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_397_inst_req_0 <= cp_elements(336);
    cp_elements(337) <= cp_elements(2);
    cp_elements(338) <= cp_elements(311);
    cp_elements(339) <= binary_397_inst_ack_0;
    binary_397_inst_req_1 <= cp_elements(339);
    cp_elements(340) <= binary_397_inst_ack_1;
    cpelement_group_341 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(342) & cp_elements(343));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(341),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_403_inst_req_0 <= cp_elements(341);
    cp_elements(342) <= cp_elements(2);
    cp_elements(343) <= cp_elements(330);
    cp_elements(344) <= binary_403_inst_ack_0;
    binary_403_inst_req_1 <= cp_elements(344);
    cp_elements(345) <= binary_403_inst_ack_1;
    cpelement_group_346 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(335) & cp_elements(340) & cp_elements(347));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(346),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_408_inst_req_0 <= cp_elements(346);
    cp_elements(347) <= cp_elements(2);
    cp_elements(348) <= binary_408_inst_ack_0;
    binary_408_inst_req_1 <= cp_elements(348);
    cp_elements(349) <= binary_408_inst_ack_1;
    cpelement_group_350 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(345) & cp_elements(349) & cp_elements(351));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(350),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_413_inst_req_0 <= cp_elements(350);
    cp_elements(351) <= cp_elements(2);
    cp_elements(352) <= binary_413_inst_ack_0;
    binary_413_inst_req_1 <= cp_elements(352);
    cp_elements(353) <= binary_413_inst_ack_1;
    cpelement_group_354 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(353) & cp_elements(355));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(354),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_419_inst_req_0 <= cp_elements(354);
    cp_elements(355) <= cp_elements(2);
    cp_elements(356) <= binary_419_inst_ack_0;
    binary_419_inst_req_1 <= cp_elements(356);
    cp_elements(357) <= binary_419_inst_ack_1;
    cp_elements(358) <= cp_elements(292);
    cpelement_group_359 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(4) & cp_elements(358) & cp_elements(360));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(359),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_421_gather_scatter_req_0 <= cp_elements(359);
    cp_elements(360) <= cp_elements(2);
    cp_elements(361) <= simple_obj_ref_421_gather_scatter_ack_0;
    simple_obj_ref_421_store_0_req_0 <= cp_elements(361);
    cp_elements(362) <= simple_obj_ref_421_store_0_ack_0;
    simple_obj_ref_421_store_0_req_1 <= cp_elements(362);
    cp_elements(363) <= simple_obj_ref_421_store_0_ack_1;
    cp_elements(364) <= cp_elements(311);
    cpelement_group_365 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(9) & cp_elements(364) & cp_elements(366));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(365),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_424_gather_scatter_req_0 <= cp_elements(365);
    cp_elements(366) <= cp_elements(2);
    cp_elements(367) <= simple_obj_ref_424_gather_scatter_ack_0;
    simple_obj_ref_424_store_0_req_0 <= cp_elements(367);
    cp_elements(368) <= simple_obj_ref_424_store_0_ack_0;
    simple_obj_ref_424_store_0_req_1 <= cp_elements(368);
    cp_elements(369) <= simple_obj_ref_424_store_0_ack_1;
    cp_elements(370) <= cp_elements(330);
    cpelement_group_371 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(14) & cp_elements(370) & cp_elements(372));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(371),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_427_gather_scatter_req_0 <= cp_elements(371);
    cp_elements(372) <= cp_elements(2);
    cp_elements(373) <= simple_obj_ref_427_gather_scatter_ack_0;
    simple_obj_ref_427_store_0_req_0 <= cp_elements(373);
    cp_elements(374) <= simple_obj_ref_427_store_0_ack_0;
    simple_obj_ref_427_store_0_req_1 <= cp_elements(374);
    cp_elements(375) <= simple_obj_ref_427_store_0_ack_1;
    cpelement_group_376 : Block -- 
      signal predecessors: BooleanArray(3 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(357) & cp_elements(363) & cp_elements(369) & cp_elements(375));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(376),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal iNsTr_0_16 : std_logic_vector(31 downto 0);
    signal iNsTr_10_70 : std_logic_vector(31 downto 0);
    signal iNsTr_11_76 : std_logic_vector(31 downto 0);
    signal iNsTr_12_82 : std_logic_vector(31 downto 0);
    signal iNsTr_13_88 : std_logic_vector(31 downto 0);
    signal iNsTr_14_93 : std_logic_vector(31 downto 0);
    signal iNsTr_15_99 : std_logic_vector(31 downto 0);
    signal iNsTr_16_104 : std_logic_vector(31 downto 0);
    signal iNsTr_17_109 : std_logic_vector(31 downto 0);
    signal iNsTr_18_114 : std_logic_vector(31 downto 0);
    signal iNsTr_19_119 : std_logic_vector(31 downto 0);
    signal iNsTr_1_19 : std_logic_vector(31 downto 0);
    signal iNsTr_20_124 : std_logic_vector(31 downto 0);
    signal iNsTr_21_129 : std_logic_vector(31 downto 0);
    signal iNsTr_22_134 : std_logic_vector(31 downto 0);
    signal iNsTr_23_139 : std_logic_vector(31 downto 0);
    signal iNsTr_24_144 : std_logic_vector(31 downto 0);
    signal iNsTr_25_149 : std_logic_vector(31 downto 0);
    signal iNsTr_26_154 : std_logic_vector(31 downto 0);
    signal iNsTr_27_159 : std_logic_vector(31 downto 0);
    signal iNsTr_28_165 : std_logic_vector(31 downto 0);
    signal iNsTr_29_171 : std_logic_vector(31 downto 0);
    signal iNsTr_2_22 : std_logic_vector(31 downto 0);
    signal iNsTr_30_177 : std_logic_vector(31 downto 0);
    signal iNsTr_31_183 : std_logic_vector(31 downto 0);
    signal iNsTr_32_188 : std_logic_vector(31 downto 0);
    signal iNsTr_33_193 : std_logic_vector(31 downto 0);
    signal iNsTr_34_198 : std_logic_vector(31 downto 0);
    signal iNsTr_35_204 : std_logic_vector(31 downto 0);
    signal iNsTr_36_210 : std_logic_vector(31 downto 0);
    signal iNsTr_37_216 : std_logic_vector(31 downto 0);
    signal iNsTr_38_221 : std_logic_vector(31 downto 0);
    signal iNsTr_39_227 : std_logic_vector(31 downto 0);
    signal iNsTr_3_28 : std_logic_vector(31 downto 0);
    signal iNsTr_40_233 : std_logic_vector(31 downto 0);
    signal iNsTr_41_238 : std_logic_vector(31 downto 0);
    signal iNsTr_42_244 : std_logic_vector(31 downto 0);
    signal iNsTr_43_250 : std_logic_vector(31 downto 0);
    signal iNsTr_44_256 : std_logic_vector(31 downto 0);
    signal iNsTr_45_261 : std_logic_vector(31 downto 0);
    signal iNsTr_46_267 : std_logic_vector(31 downto 0);
    signal iNsTr_47_273 : std_logic_vector(31 downto 0);
    signal iNsTr_48_279 : std_logic_vector(31 downto 0);
    signal iNsTr_49_285 : std_logic_vector(31 downto 0);
    signal iNsTr_4_34 : std_logic_vector(31 downto 0);
    signal iNsTr_50_290 : std_logic_vector(31 downto 0);
    signal iNsTr_51_295 : std_logic_vector(31 downto 0);
    signal iNsTr_52_300 : std_logic_vector(31 downto 0);
    signal iNsTr_53_306 : std_logic_vector(31 downto 0);
    signal iNsTr_54_312 : std_logic_vector(31 downto 0);
    signal iNsTr_55_318 : std_logic_vector(31 downto 0);
    signal iNsTr_56_323 : std_logic_vector(31 downto 0);
    signal iNsTr_57_328 : std_logic_vector(31 downto 0);
    signal iNsTr_58_334 : std_logic_vector(31 downto 0);
    signal iNsTr_59_339 : std_logic_vector(31 downto 0);
    signal iNsTr_5_40 : std_logic_vector(31 downto 0);
    signal iNsTr_60_344 : std_logic_vector(31 downto 0);
    signal iNsTr_61_349 : std_logic_vector(31 downto 0);
    signal iNsTr_62_355 : std_logic_vector(31 downto 0);
    signal iNsTr_63_360 : std_logic_vector(31 downto 0);
    signal iNsTr_64_365 : std_logic_vector(31 downto 0);
    signal iNsTr_65_370 : std_logic_vector(31 downto 0);
    signal iNsTr_66_376 : std_logic_vector(31 downto 0);
    signal iNsTr_67_381 : std_logic_vector(31 downto 0);
    signal iNsTr_68_386 : std_logic_vector(31 downto 0);
    signal iNsTr_69_392 : std_logic_vector(31 downto 0);
    signal iNsTr_6_46 : std_logic_vector(31 downto 0);
    signal iNsTr_70_398 : std_logic_vector(31 downto 0);
    signal iNsTr_71_404 : std_logic_vector(31 downto 0);
    signal iNsTr_72_409 : std_logic_vector(31 downto 0);
    signal iNsTr_73_414 : std_logic_vector(31 downto 0);
    signal iNsTr_7_52 : std_logic_vector(31 downto 0);
    signal iNsTr_8_58 : std_logic_vector(31 downto 0);
    signal iNsTr_9_64 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_15_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_15_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_18_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_18_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_21_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_21_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_421_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_421_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_424_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_424_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_427_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_427_word_address_0 : std_logic_vector(0 downto 0);
    signal type_cast_163_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_169_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_175_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_181_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_202_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_208_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_214_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_225_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_231_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_242_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_248_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_254_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_265_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_26_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_271_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_277_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_283_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_304_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_310_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_316_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_32_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_332_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_353_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_374_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_38_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_390_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_396_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_402_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_418_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_44_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_49_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_56_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_61_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_68_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_73_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_80_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_86_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_97_wire_constant : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    simple_obj_ref_15_word_address_0 <= "0";
    simple_obj_ref_18_word_address_0 <= "0";
    simple_obj_ref_21_word_address_0 <= "0";
    simple_obj_ref_421_word_address_0 <= "0";
    simple_obj_ref_424_word_address_0 <= "0";
    simple_obj_ref_427_word_address_0 <= "0";
    type_cast_163_wire_constant <= "00000000000000000000000000010010";
    type_cast_169_wire_constant <= "00000000000000000000000000010001";
    type_cast_175_wire_constant <= "00000000000000000000000000010000";
    type_cast_181_wire_constant <= "00000000000000000000000000001101";
    type_cast_202_wire_constant <= "00000000000000000000000000000001";
    type_cast_208_wire_constant <= "00000000000000000000000000000001";
    type_cast_214_wire_constant <= "00000000000001111111111111111110";
    type_cast_225_wire_constant <= "00000000000000000000000000010101";
    type_cast_231_wire_constant <= "00000000000000000000000000010100";
    type_cast_242_wire_constant <= "00000000000000000000000000000001";
    type_cast_248_wire_constant <= "00000000000000000000000000000001";
    type_cast_254_wire_constant <= "00000000001111111111111111111110";
    type_cast_265_wire_constant <= "00000000000000000000000000010110";
    type_cast_26_wire_constant <= "00000000000000000000000000001000";
    type_cast_271_wire_constant <= "00000000000000000000000000010101";
    type_cast_277_wire_constant <= "00000000000000000000000000010100";
    type_cast_283_wire_constant <= "00000000000000000000000000000111";
    type_cast_304_wire_constant <= "00000000000000000000000000000001";
    type_cast_310_wire_constant <= "00000000000000000000000000000001";
    type_cast_316_wire_constant <= "00000000011111111111111111111110";
    type_cast_32_wire_constant <= "00000000000000000000000000001010";
    type_cast_332_wire_constant <= "11111111111111111111111111111111";
    type_cast_353_wire_constant <= "11111111111111111111111111111111";
    type_cast_374_wire_constant <= "11111111111111111111111111111111";
    type_cast_38_wire_constant <= "00000000000000000000000000001010";
    type_cast_390_wire_constant <= "00000000000000000000000000010010";
    type_cast_396_wire_constant <= "00000000000000000000000000010101";
    type_cast_402_wire_constant <= "00000000000000000000000000010110";
    type_cast_418_wire_constant <= "00000000000000000000000000000001";
    type_cast_44_wire_constant <= "00000000000000000000000000000001";
    type_cast_49_wire_constant <= "00000000000000000000000000000000";
    type_cast_56_wire_constant <= "00000000000000000000000000000001";
    type_cast_61_wire_constant <= "00000000000000000000000000000000";
    type_cast_68_wire_constant <= "00000000000000000000000000000001";
    type_cast_73_wire_constant <= "00000000000000000000000000000000";
    type_cast_80_wire_constant <= "11111111111111111111111111111111";
    type_cast_86_wire_constant <= "11111111111111111111111111111111";
    type_cast_97_wire_constant <= "11111111111111111111111111111111";
    simple_obj_ref_15_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_15_gather_scatter_ack_0 <= simple_obj_ref_15_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_15_data_0;
      iNsTr_0_16 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_18_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_18_gather_scatter_ack_0 <= simple_obj_ref_18_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_18_data_0;
      iNsTr_1_19 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_21_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_21_gather_scatter_ack_0 <= simple_obj_ref_21_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_21_data_0;
      iNsTr_2_22 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_421_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_421_gather_scatter_ack_0 <= simple_obj_ref_421_gather_scatter_req_0;
      aggregated_sig <= iNsTr_60_344;
      simple_obj_ref_421_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_424_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_424_gather_scatter_ack_0 <= simple_obj_ref_424_gather_scatter_req_0;
      aggregated_sig <= iNsTr_64_365;
      simple_obj_ref_424_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_427_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_427_gather_scatter_ack_0 <= simple_obj_ref_427_gather_scatter_req_0;
      aggregated_sig <= iNsTr_68_386;
      simple_obj_ref_427_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    -- shared split operator group (0) : binary_103_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_15_99 & iNsTr_11_76;
      iNsTr_16_104 <= data_out(31 downto 0);
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
          reqL => binary_103_inst_req_0,
          ackL => binary_103_inst_ack_0,
          reqR => binary_103_inst_req_1,
          ackR => binary_103_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : binary_108_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_9_64 & iNsTr_7_52;
      iNsTr_17_109 <= data_out(31 downto 0);
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
          reqL => binary_108_inst_req_0,
          ackL => binary_108_inst_ack_0,
          reqR => binary_108_inst_req_1,
          ackR => binary_108_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : binary_113_inst 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_16_104 & iNsTr_17_109;
      iNsTr_18_114 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_113_inst_req_0,
          ackL => binary_113_inst_ack_0,
          reqR => binary_113_inst_req_1,
          ackR => binary_113_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : binary_118_inst 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_18_114 & iNsTr_14_93;
      iNsTr_19_119 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_118_inst_req_0,
          ackL => binary_118_inst_ack_0,
          reqR => binary_118_inst_req_1,
          ackR => binary_118_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : binary_123_inst 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_15_99 & iNsTr_9_64;
      iNsTr_20_124 <= data_out(31 downto 0);
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
          reqL => binary_123_inst_req_0,
          ackL => binary_123_inst_ack_0,
          reqR => binary_123_inst_req_1,
          ackR => binary_123_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared split operator group (5) : binary_128_inst 
    SplitOperatorGroup5: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_11_76 & iNsTr_7_52;
      iNsTr_21_129 <= data_out(31 downto 0);
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
          reqL => binary_128_inst_req_0,
          ackL => binary_128_inst_ack_0,
          reqR => binary_128_inst_req_1,
          ackR => binary_128_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 5
    -- shared split operator group (6) : binary_133_inst 
    SplitOperatorGroup6: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_21_129 & iNsTr_20_124;
      iNsTr_22_134 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_133_inst_req_0,
          ackL => binary_133_inst_ack_0,
          reqR => binary_133_inst_req_1,
          ackR => binary_133_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 6
    -- shared split operator group (7) : binary_138_inst 
    SplitOperatorGroup7: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_22_134 & iNsTr_14_93;
      iNsTr_23_139 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_138_inst_req_0,
          ackL => binary_138_inst_ack_0,
          reqR => binary_138_inst_req_1,
          ackR => binary_138_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 7
    -- shared split operator group (8) : binary_143_inst 
    SplitOperatorGroup8: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_13_88 & iNsTr_15_99;
      iNsTr_24_144 <= data_out(31 downto 0);
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
          reqL => binary_143_inst_req_0,
          ackL => binary_143_inst_ack_0,
          reqR => binary_143_inst_req_1,
          ackR => binary_143_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 8
    -- shared split operator group (9) : binary_148_inst 
    SplitOperatorGroup9: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_12_82 & iNsTr_11_76;
      iNsTr_25_149 <= data_out(31 downto 0);
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
          reqL => binary_148_inst_req_0,
          ackL => binary_148_inst_ack_0,
          reqR => binary_148_inst_req_1,
          ackR => binary_148_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 9
    -- shared split operator group (10) : binary_153_inst 
    SplitOperatorGroup10: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_25_149 & iNsTr_17_109;
      iNsTr_26_154 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_153_inst_req_0,
          ackL => binary_153_inst_ack_0,
          reqR => binary_153_inst_req_1,
          ackR => binary_153_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 10
    -- shared split operator group (11) : binary_158_inst 
    SplitOperatorGroup11: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_26_154 & iNsTr_24_144;
      iNsTr_27_159 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_158_inst_req_0,
          ackL => binary_158_inst_ack_0,
          reqR => binary_158_inst_req_1,
          ackR => binary_158_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 11
    -- shared split operator group (12) : binary_164_inst 
    SplitOperatorGroup12: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_0_16;
      iNsTr_28_165 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010010",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_164_inst_req_0,
          ackL => binary_164_inst_ack_0,
          reqR => binary_164_inst_req_1,
          ackR => binary_164_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 12
    -- shared split operator group (13) : binary_170_inst 
    SplitOperatorGroup13: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_0_16;
      iNsTr_29_171 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
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
    end Block; -- split operator group 13
    -- shared split operator group (14) : binary_176_inst 
    SplitOperatorGroup14: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_0_16;
      iNsTr_30_177 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_176_inst_req_0,
          ackL => binary_176_inst_ack_0,
          reqR => binary_176_inst_req_1,
          ackR => binary_176_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 14
    -- shared split operator group (15) : binary_182_inst 
    SplitOperatorGroup15: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_0_16;
      iNsTr_31_183 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000001101",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_182_inst_req_0,
          ackL => binary_182_inst_ack_0,
          reqR => binary_182_inst_req_1,
          ackR => binary_182_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 15
    -- shared split operator group (16) : binary_187_inst 
    SplitOperatorGroup16: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_31_183 & iNsTr_30_177;
      iNsTr_32_188 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_187_inst_req_0,
          ackL => binary_187_inst_ack_0,
          reqR => binary_187_inst_req_1,
          ackR => binary_187_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 16
    -- shared split operator group (17) : binary_192_inst 
    SplitOperatorGroup17: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_32_188 & iNsTr_29_171;
      iNsTr_33_193 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_192_inst_req_0,
          ackL => binary_192_inst_ack_0,
          reqR => binary_192_inst_req_1,
          ackR => binary_192_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 17
    -- shared split operator group (18) : binary_197_inst 
    SplitOperatorGroup18: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_33_193 & iNsTr_28_165;
      iNsTr_34_198 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_197_inst_req_0,
          ackL => binary_197_inst_ack_0,
          reqR => binary_197_inst_req_1,
          ackR => binary_197_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 18
    -- shared split operator group (19) : binary_203_inst 
    SplitOperatorGroup19: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_34_198;
      iNsTr_35_204 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_203_inst_req_0,
          ackL => binary_203_inst_ack_0,
          reqR => binary_203_inst_req_1,
          ackR => binary_203_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 19
    -- shared split operator group (20) : binary_209_inst 
    SplitOperatorGroup20: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_0_16;
      iNsTr_36_210 <= data_out(31 downto 0);
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
          reqL => binary_209_inst_req_0,
          ackL => binary_209_inst_ack_0,
          reqR => binary_209_inst_req_1,
          ackR => binary_209_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 20
    -- shared split operator group (21) : binary_215_inst 
    SplitOperatorGroup21: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_36_210;
      iNsTr_37_216 <= data_out(31 downto 0);
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
          constant_operand => "00000000000001111111111111111110",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_215_inst_req_0,
          ackL => binary_215_inst_ack_0,
          reqR => binary_215_inst_req_1,
          ackR => binary_215_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 21
    -- shared split operator group (22) : binary_220_inst 
    SplitOperatorGroup22: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_35_204 & iNsTr_37_216;
      iNsTr_38_221 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_220_inst_req_0,
          ackL => binary_220_inst_ack_0,
          reqR => binary_220_inst_req_1,
          ackR => binary_220_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 22
    -- shared split operator group (23) : binary_226_inst 
    SplitOperatorGroup23: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_1_19;
      iNsTr_39_227 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010101",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_226_inst_req_0,
          ackL => binary_226_inst_ack_0,
          reqR => binary_226_inst_req_1,
          ackR => binary_226_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 23
    -- shared split operator group (24) : binary_232_inst 
    SplitOperatorGroup24: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_1_19;
      iNsTr_40_233 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010100",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_232_inst_req_0,
          ackL => binary_232_inst_ack_0,
          reqR => binary_232_inst_req_1,
          ackR => binary_232_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 24
    -- shared split operator group (25) : binary_237_inst 
    SplitOperatorGroup25: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_39_227 & iNsTr_40_233;
      iNsTr_41_238 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_237_inst_req_0,
          ackL => binary_237_inst_ack_0,
          reqR => binary_237_inst_req_1,
          ackR => binary_237_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 25
    -- shared split operator group (26) : binary_243_inst 
    SplitOperatorGroup26: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_41_238;
      iNsTr_42_244 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_243_inst_req_0,
          ackL => binary_243_inst_ack_0,
          reqR => binary_243_inst_req_1,
          ackR => binary_243_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 26
    -- shared split operator group (27) : binary_249_inst 
    SplitOperatorGroup27: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_1_19;
      iNsTr_43_250 <= data_out(31 downto 0);
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
          reqL => binary_249_inst_req_0,
          ackL => binary_249_inst_ack_0,
          reqR => binary_249_inst_req_1,
          ackR => binary_249_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 27
    -- shared split operator group (28) : binary_255_inst 
    SplitOperatorGroup28: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_43_250;
      iNsTr_44_256 <= data_out(31 downto 0);
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
          constant_operand => "00000000001111111111111111111110",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_255_inst_req_0,
          ackL => binary_255_inst_ack_0,
          reqR => binary_255_inst_req_1,
          ackR => binary_255_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 28
    -- shared split operator group (29) : binary_260_inst 
    SplitOperatorGroup29: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_42_244 & iNsTr_44_256;
      iNsTr_45_261 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_260_inst_req_0,
          ackL => binary_260_inst_ack_0,
          reqR => binary_260_inst_req_1,
          ackR => binary_260_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 29
    -- shared split operator group (30) : binary_266_inst 
    SplitOperatorGroup30: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_2_22;
      iNsTr_46_267 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010110",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_266_inst_req_0,
          ackL => binary_266_inst_ack_0,
          reqR => binary_266_inst_req_1,
          ackR => binary_266_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 30
    -- shared split operator group (31) : binary_272_inst 
    SplitOperatorGroup31: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_2_22;
      iNsTr_47_273 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010101",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_272_inst_req_0,
          ackL => binary_272_inst_ack_0,
          reqR => binary_272_inst_req_1,
          ackR => binary_272_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 31
    -- shared split operator group (32) : binary_278_inst 
    SplitOperatorGroup32: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_2_22;
      iNsTr_48_279 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010100",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_278_inst_req_0,
          ackL => binary_278_inst_ack_0,
          reqR => binary_278_inst_req_1,
          ackR => binary_278_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 32
    -- shared split operator group (33) : binary_27_inst 
    SplitOperatorGroup33: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_0_16;
      iNsTr_3_28 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000001000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_27_inst_req_0,
          ackL => binary_27_inst_ack_0,
          reqR => binary_27_inst_req_1,
          ackR => binary_27_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 33
    -- shared split operator group (34) : binary_284_inst 
    SplitOperatorGroup34: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_2_22;
      iNsTr_49_285 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000111",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_284_inst_req_0,
          ackL => binary_284_inst_ack_0,
          reqR => binary_284_inst_req_1,
          ackR => binary_284_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 34
    -- shared split operator group (35) : binary_289_inst 
    SplitOperatorGroup35: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_49_285 & iNsTr_48_279;
      iNsTr_50_290 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_289_inst_req_0,
          ackL => binary_289_inst_ack_0,
          reqR => binary_289_inst_req_1,
          ackR => binary_289_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 35
    -- shared split operator group (36) : binary_294_inst 
    SplitOperatorGroup36: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_50_290 & iNsTr_47_273;
      iNsTr_51_295 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_294_inst_req_0,
          ackL => binary_294_inst_ack_0,
          reqR => binary_294_inst_req_1,
          ackR => binary_294_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 36
    -- shared split operator group (37) : binary_299_inst 
    SplitOperatorGroup37: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_51_295 & iNsTr_46_267;
      iNsTr_52_300 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_299_inst_req_0,
          ackL => binary_299_inst_ack_0,
          reqR => binary_299_inst_req_1,
          ackR => binary_299_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 37
    -- shared split operator group (38) : binary_305_inst 
    SplitOperatorGroup38: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_52_300;
      iNsTr_53_306 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_305_inst_req_0,
          ackL => binary_305_inst_ack_0,
          reqR => binary_305_inst_req_1,
          ackR => binary_305_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 38
    -- shared split operator group (39) : binary_311_inst 
    SplitOperatorGroup39: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_2_22;
      iNsTr_54_312 <= data_out(31 downto 0);
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
          reqL => binary_311_inst_req_0,
          ackL => binary_311_inst_ack_0,
          reqR => binary_311_inst_req_1,
          ackR => binary_311_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 39
    -- shared split operator group (40) : binary_317_inst 
    SplitOperatorGroup40: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_54_312;
      iNsTr_55_318 <= data_out(31 downto 0);
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
          constant_operand => "00000000011111111111111111111110",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_317_inst_req_0,
          ackL => binary_317_inst_ack_0,
          reqR => binary_317_inst_req_1,
          ackR => binary_317_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 40
    -- shared split operator group (41) : binary_322_inst 
    SplitOperatorGroup41: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_53_306 & iNsTr_55_318;
      iNsTr_56_323 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_322_inst_req_0,
          ackL => binary_322_inst_ack_0,
          reqR => binary_322_inst_req_1,
          ackR => binary_322_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 41
    -- shared split operator group (42) : binary_327_inst 
    SplitOperatorGroup42: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_27_159 & iNsTr_38_221;
      iNsTr_57_328 <= data_out(31 downto 0);
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
          reqL => binary_327_inst_req_0,
          ackL => binary_327_inst_ack_0,
          reqR => binary_327_inst_req_1,
          ackR => binary_327_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 42
    -- shared split operator group (43) : binary_333_inst 
    SplitOperatorGroup43: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_27_159;
      iNsTr_58_334 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_333_inst_req_0,
          ackL => binary_333_inst_ack_0,
          reqR => binary_333_inst_req_1,
          ackR => binary_333_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 43
    -- shared split operator group (44) : binary_338_inst 
    SplitOperatorGroup44: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_0_16 & iNsTr_58_334;
      iNsTr_59_339 <= data_out(31 downto 0);
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
          reqL => binary_338_inst_req_0,
          ackL => binary_338_inst_ack_0,
          reqR => binary_338_inst_req_1,
          ackR => binary_338_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 44
    -- shared split operator group (45) : binary_33_inst 
    SplitOperatorGroup45: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_1_19;
      iNsTr_4_34 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000001010",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_33_inst_req_0,
          ackL => binary_33_inst_ack_0,
          reqR => binary_33_inst_req_1,
          ackR => binary_33_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 45
    -- shared split operator group (46) : binary_343_inst 
    SplitOperatorGroup46: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_57_328 & iNsTr_59_339;
      iNsTr_60_344 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_343_inst_req_0,
          ackL => binary_343_inst_ack_0,
          reqR => binary_343_inst_req_1,
          ackR => binary_343_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 46
    -- shared split operator group (47) : binary_348_inst 
    SplitOperatorGroup47: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_19_119 & iNsTr_45_261;
      iNsTr_61_349 <= data_out(31 downto 0);
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
          reqL => binary_348_inst_req_0,
          ackL => binary_348_inst_ack_0,
          reqR => binary_348_inst_req_1,
          ackR => binary_348_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 47
    -- shared split operator group (48) : binary_354_inst 
    SplitOperatorGroup48: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_19_119;
      iNsTr_62_355 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_354_inst_req_0,
          ackL => binary_354_inst_ack_0,
          reqR => binary_354_inst_req_1,
          ackR => binary_354_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 48
    -- shared split operator group (49) : binary_359_inst 
    SplitOperatorGroup49: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_1_19 & iNsTr_62_355;
      iNsTr_63_360 <= data_out(31 downto 0);
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
          reqL => binary_359_inst_req_0,
          ackL => binary_359_inst_ack_0,
          reqR => binary_359_inst_req_1,
          ackR => binary_359_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 49
    -- shared split operator group (50) : binary_364_inst 
    SplitOperatorGroup50: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_61_349 & iNsTr_63_360;
      iNsTr_64_365 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_364_inst_req_0,
          ackL => binary_364_inst_ack_0,
          reqR => binary_364_inst_req_1,
          ackR => binary_364_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 50
    -- shared split operator group (51) : binary_369_inst 
    SplitOperatorGroup51: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_56_323 & iNsTr_23_139;
      iNsTr_65_370 <= data_out(31 downto 0);
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
          reqL => binary_369_inst_req_0,
          ackL => binary_369_inst_ack_0,
          reqR => binary_369_inst_req_1,
          ackR => binary_369_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 51
    -- shared split operator group (52) : binary_375_inst 
    SplitOperatorGroup52: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_23_139;
      iNsTr_66_376 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_375_inst_req_0,
          ackL => binary_375_inst_ack_0,
          reqR => binary_375_inst_req_1,
          ackR => binary_375_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 52
    -- shared split operator group (53) : binary_380_inst 
    SplitOperatorGroup53: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_2_22 & iNsTr_66_376;
      iNsTr_67_381 <= data_out(31 downto 0);
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
          reqL => binary_380_inst_req_0,
          ackL => binary_380_inst_ack_0,
          reqR => binary_380_inst_req_1,
          ackR => binary_380_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 53
    -- shared split operator group (54) : binary_385_inst 
    SplitOperatorGroup54: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_65_370 & iNsTr_67_381;
      iNsTr_68_386 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_385_inst_req_0,
          ackL => binary_385_inst_ack_0,
          reqR => binary_385_inst_req_1,
          ackR => binary_385_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 54
    -- shared split operator group (55) : binary_391_inst 
    SplitOperatorGroup55: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_60_344;
      iNsTr_69_392 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010010",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_391_inst_req_0,
          ackL => binary_391_inst_ack_0,
          reqR => binary_391_inst_req_1,
          ackR => binary_391_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 55
    -- shared split operator group (56) : binary_397_inst 
    SplitOperatorGroup56: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_64_365;
      iNsTr_70_398 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010101",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_397_inst_req_0,
          ackL => binary_397_inst_ack_0,
          reqR => binary_397_inst_req_1,
          ackR => binary_397_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 56
    -- shared split operator group (57) : binary_39_inst 
    SplitOperatorGroup57: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_2_22;
      iNsTr_5_40 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000001010",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_39_inst_req_0,
          ackL => binary_39_inst_ack_0,
          reqR => binary_39_inst_req_1,
          ackR => binary_39_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 57
    -- shared split operator group (58) : binary_403_inst 
    SplitOperatorGroup58: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_68_386;
      iNsTr_71_404 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000010110",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_403_inst_req_0,
          ackL => binary_403_inst_ack_0,
          reqR => binary_403_inst_req_1,
          ackR => binary_403_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 58
    -- shared split operator group (59) : binary_408_inst 
    SplitOperatorGroup59: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_69_392 & iNsTr_70_398;
      iNsTr_72_409 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_408_inst_req_0,
          ackL => binary_408_inst_ack_0,
          reqR => binary_408_inst_req_1,
          ackR => binary_408_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 59
    -- shared split operator group (60) : binary_413_inst 
    SplitOperatorGroup60: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_72_409 & iNsTr_71_404;
      iNsTr_73_414 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          reqL => binary_413_inst_req_0,
          ackL => binary_413_inst_ack_0,
          reqR => binary_413_inst_req_1,
          ackR => binary_413_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 60
    -- shared split operator group (61) : binary_419_inst 
    SplitOperatorGroup61: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_73_414;
      ret_val_x_x_buffer <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_419_inst_req_0,
          ackL => binary_419_inst_ack_0,
          reqR => binary_419_inst_req_1,
          ackR => binary_419_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 61
    -- shared split operator group (62) : binary_45_inst 
    SplitOperatorGroup62: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_3_28;
      iNsTr_6_46 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_45_inst_req_0,
          ackL => binary_45_inst_ack_0,
          reqR => binary_45_inst_req_1,
          ackR => binary_45_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 62
    -- shared split operator group (63) : binary_51_inst 
    SplitOperatorGroup63: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= type_cast_49_wire_constant & iNsTr_6_46;
      iNsTr_7_52 <= data_out(31 downto 0);
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
          reqL => binary_51_inst_req_0,
          ackL => binary_51_inst_ack_0,
          reqR => binary_51_inst_req_1,
          ackR => binary_51_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 63
    -- shared split operator group (64) : binary_57_inst 
    SplitOperatorGroup64: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_4_34;
      iNsTr_8_58 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_57_inst_req_0,
          ackL => binary_57_inst_ack_0,
          reqR => binary_57_inst_req_1,
          ackR => binary_57_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 64
    -- shared split operator group (65) : binary_63_inst 
    SplitOperatorGroup65: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= type_cast_61_wire_constant & iNsTr_8_58;
      iNsTr_9_64 <= data_out(31 downto 0);
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
          reqL => binary_63_inst_req_0,
          ackL => binary_63_inst_ack_0,
          reqR => binary_63_inst_req_1,
          ackR => binary_63_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 65
    -- shared split operator group (66) : binary_69_inst 
    SplitOperatorGroup66: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_5_40;
      iNsTr_10_70 <= data_out(31 downto 0);
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
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_69_inst_req_0,
          ackL => binary_69_inst_ack_0,
          reqR => binary_69_inst_req_1,
          ackR => binary_69_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 66
    -- shared split operator group (67) : binary_75_inst 
    SplitOperatorGroup67: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= type_cast_73_wire_constant & iNsTr_10_70;
      iNsTr_11_76 <= data_out(31 downto 0);
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
          reqL => binary_75_inst_req_0,
          ackL => binary_75_inst_ack_0,
          reqR => binary_75_inst_req_1,
          ackR => binary_75_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 67
    -- shared split operator group (68) : binary_81_inst 
    SplitOperatorGroup68: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_8_58;
      iNsTr_12_82 <= data_out(31 downto 0);
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
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_81_inst_req_0,
          ackL => binary_81_inst_ack_0,
          reqR => binary_81_inst_req_1,
          ackR => binary_81_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 68
    -- shared split operator group (69) : binary_87_inst 
    SplitOperatorGroup69: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_10_70;
      iNsTr_13_88 <= data_out(31 downto 0);
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
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_87_inst_req_0,
          ackL => binary_87_inst_ack_0,
          reqR => binary_87_inst_req_1,
          ackR => binary_87_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 69
    -- shared split operator group (70) : binary_92_inst 
    SplitOperatorGroup70: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_13_88 & iNsTr_12_82;
      iNsTr_14_93 <= data_out(31 downto 0);
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
          reqL => binary_92_inst_req_0,
          ackL => binary_92_inst_ack_0,
          reqR => binary_92_inst_req_1,
          ackR => binary_92_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 70
    -- shared split operator group (71) : binary_98_inst 
    SplitOperatorGroup71: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_6_46;
      iNsTr_15_99 <= data_out(31 downto 0);
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
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_98_inst_req_0,
          ackL => binary_98_inst_ack_0,
          reqR => binary_98_inst_req_1,
          ackR => binary_98_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 71
    -- shared load operator group (0) : simple_obj_ref_15_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_15_load_0_req_0;
      simple_obj_ref_15_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_15_load_0_req_1;
      simple_obj_ref_15_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_15_word_address_0;
      simple_obj_ref_15_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 2, min_clock_period => true,
        no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(0),
          mack => memory_space_0_lr_ack(0),
          maddr => memory_space_0_lr_addr(0 downto 0),
          mtag => memory_space_0_lr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(0),
          mack => memory_space_0_lc_ack(0),
          mdata => memory_space_0_lc_data(31 downto 0),
          mtag => memory_space_0_lc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- shared load operator group (1) : simple_obj_ref_18_load_0 
    LoadGroup1: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_18_load_0_req_0;
      simple_obj_ref_18_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_18_load_0_req_1;
      simple_obj_ref_18_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_18_word_address_0;
      simple_obj_ref_18_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 2, min_clock_period => true,
        no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_1_lr_req(0),
          mack => memory_space_1_lr_ack(0),
          maddr => memory_space_1_lr_addr(0 downto 0),
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
    end Block; -- load group 1
    -- shared load operator group (2) : simple_obj_ref_21_load_0 
    LoadGroup2: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_21_load_0_req_0;
      simple_obj_ref_21_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_21_load_0_req_1;
      simple_obj_ref_21_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_21_word_address_0;
      simple_obj_ref_21_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 2, min_clock_period => true,
        no_arbitration => true)
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
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
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
    end Block; -- load group 2
    -- shared store operator group (0) : simple_obj_ref_421_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_421_store_0_req_0;
      simple_obj_ref_421_store_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_421_store_0_req_1;
      simple_obj_ref_421_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_421_word_address_0;
      data_in <= simple_obj_ref_421_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 2,
        min_clock_period => true,
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
    -- shared store operator group (1) : simple_obj_ref_424_store_0 
    StoreGroup1: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_424_store_0_req_0;
      simple_obj_ref_424_store_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_424_store_0_req_1;
      simple_obj_ref_424_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_424_word_address_0;
      data_in <= simple_obj_ref_424_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 2,
        min_clock_period => true,
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
    -- shared store operator group (2) : simple_obj_ref_427_store_0 
    StoreGroup2: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_427_store_0_req_0;
      simple_obj_ref_427_store_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_427_store_0_req_1;
      simple_obj_ref_427_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_427_word_address_0;
      data_in <= simple_obj_ref_427_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 2,
        min_clock_period => true,
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
          num_reqs => 1,
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
entity main_inner is -- 
  generic (tag_length : integer); 
  port ( -- 
    ret_val_x_x : out  std_logic_vector(31 downto 0);
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic;
    memory_space_2_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_2_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_lr_addr : out  std_logic_vector(0 downto 0);
    memory_space_2_lr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_2_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_2_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_2_lc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_0_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_0_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_lr_addr : out  std_logic_vector(0 downto 0);
    memory_space_0_lr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_0_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_0_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_0_lc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_1_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_1_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_lr_addr : out  std_logic_vector(0 downto 0);
    memory_space_1_lr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_1_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_1_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_1_lc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_2_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_2_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_sr_addr : out  std_logic_vector(0 downto 0);
    memory_space_2_sr_data : out  std_logic_vector(31 downto 0);
    memory_space_2_sr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_2_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_2_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_sc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_0_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_0_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_sr_addr : out  std_logic_vector(0 downto 0);
    memory_space_0_sr_data : out  std_logic_vector(31 downto 0);
    memory_space_0_sr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_0_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_0_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_sc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_1_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_1_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_sr_addr : out  std_logic_vector(0 downto 0);
    memory_space_1_sr_data : out  std_logic_vector(31 downto 0);
    memory_space_1_sr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_1_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_1_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_sc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_3_sr_req : out  std_logic_vector(1 downto 0);
    memory_space_3_sr_ack : in   std_logic_vector(1 downto 0);
    memory_space_3_sr_addr : out  std_logic_vector(3 downto 0);
    memory_space_3_sr_data : out  std_logic_vector(63 downto 0);
    memory_space_3_sr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_3_sc_req : out  std_logic_vector(1 downto 0);
    memory_space_3_sc_ack : in   std_logic_vector(1 downto 0);
    memory_space_3_sc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_4_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_4_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_4_sr_addr : out  std_logic_vector(0 downto 0);
    memory_space_4_sr_data : out  std_logic_vector(31 downto 0);
    memory_space_4_sr_tag :  out  std_logic_vector(0 downto 0);
    memory_space_4_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_4_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_4_sc_tag :  in  std_logic_vector(0 downto 0);
    outpipe_pipe_write_req : out  std_logic_vector(0 downto 0);
    outpipe_pipe_write_ack : in   std_logic_vector(0 downto 0);
    outpipe_pipe_write_data : out  std_logic_vector(31 downto 0);
    a5reg_call_reqs : out  std_logic_vector(0 downto 0);
    a5reg_call_acks : in   std_logic_vector(0 downto 0);
    a5reg_call_tag  :  out  std_logic_vector(0 downto 0);
    a5reg_return_reqs : out  std_logic_vector(0 downto 0);
    a5reg_return_acks : in   std_logic_vector(0 downto 0);
    a5reg_return_data : in   std_logic_vector(31 downto 0);
    a5reg_return_tag :  in   std_logic_vector(0 downto 0);
    a5init_call_reqs : out  std_logic_vector(0 downto 0);
    a5init_call_acks : in   std_logic_vector(0 downto 0);
    a5init_call_tag  :  out  std_logic_vector(0 downto 0);
    a5init_return_reqs : out  std_logic_vector(0 downto 0);
    a5init_return_acks : in   std_logic_vector(0 downto 0);
    a5init_return_tag :  in   std_logic_vector(0 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
  );
  -- 
end entity main_inner;
architecture Default of main_inner is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal start_req_symbol: Boolean;
  signal start_ack_symbol: Boolean;
  signal fin_req_symbol: Boolean;
  signal fin_ack_symbol: Boolean;
  signal tag_push, tag_pop: std_logic; 
  signal start_ack_sig, fin_ack_sig: std_logic; 
  -- output port buffer signals
  signal ret_val_x_x_buffer :  std_logic_vector(31 downto 0);
  signal main_inner_CP_3580_start: Boolean;
  -- links between control-path and data-path
  signal simple_obj_ref_1247_load_0_req_0 : boolean;
  signal ptr_deref_1219_store_0_ack_0 : boolean;
  signal ptr_deref_1229_store_0_req_0 : boolean;
  signal ptr_deref_1219_store_0_req_0 : boolean;
  signal call_stmt_1233_call_ack_0 : boolean;
  signal simple_obj_ref_1247_load_0_ack_0 : boolean;
  signal call_stmt_1233_call_req_0 : boolean;
  signal simple_obj_ref_1247_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_1235_gather_scatter_req_0 : boolean;
  signal call_stmt_1233_call_req_1 : boolean;
  signal simple_obj_ref_1237_inst_req_0 : boolean;
  signal call_stmt_1270_call_req_0 : boolean;
  signal simple_obj_ref_1201_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_1247_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_1205_store_0_ack_0 : boolean;
  signal simple_obj_ref_1235_load_0_ack_0 : boolean;
  signal simple_obj_ref_1197_gather_scatter_ack_0 : boolean;
  signal binary_1275_inst_req_1 : boolean;
  signal simple_obj_ref_1197_gather_scatter_req_0 : boolean;
  signal binary_1275_inst_ack_0 : boolean;
  signal call_stmt_1233_call_ack_1 : boolean;
  signal simple_obj_ref_1235_gather_scatter_ack_0 : boolean;
  signal binary_1291_inst_ack_0 : boolean;
  signal binary_1297_inst_ack_0 : boolean;
  signal simple_obj_ref_1237_inst_ack_0 : boolean;
  signal binary_1275_inst_req_0 : boolean;
  signal call_stmt_1270_call_ack_1 : boolean;
  signal ptr_deref_1229_store_0_req_1 : boolean;
  signal binary_1280_inst_req_1 : boolean;
  signal simple_obj_ref_1201_gather_scatter_req_0 : boolean;
  signal ptr_deref_1219_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_1205_store_0_req_0 : boolean;
  signal simple_obj_ref_1241_load_0_ack_1 : boolean;
  signal simple_obj_ref_1201_store_0_req_0 : boolean;
  signal binary_1285_inst_ack_1 : boolean;
  signal simple_obj_ref_1201_store_0_req_1 : boolean;
  signal simple_obj_ref_1247_load_0_req_1 : boolean;
  signal binary_1280_inst_req_0 : boolean;
  signal binary_1275_inst_ack_1 : boolean;
  signal binary_1291_inst_req_0 : boolean;
  signal simple_obj_ref_1201_store_0_ack_1 : boolean;
  signal if_stmt_1299_branch_ack_1 : boolean;
  signal simple_obj_ref_1235_load_0_ack_1 : boolean;
  signal binary_1297_inst_ack_1 : boolean;
  signal binary_1297_inst_req_0 : boolean;
  signal simple_obj_ref_1205_gather_scatter_ack_0 : boolean;
  signal binary_1297_inst_req_1 : boolean;
  signal simple_obj_ref_1201_store_0_ack_0 : boolean;
  signal simple_obj_ref_1243_inst_ack_0 : boolean;
  signal simple_obj_ref_1241_load_0_req_1 : boolean;
  signal simple_obj_ref_1241_load_0_ack_0 : boolean;
  signal binary_1280_inst_ack_0 : boolean;
  signal binary_1291_inst_ack_1 : boolean;
  signal ptr_deref_1219_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_1243_inst_req_0 : boolean;
  signal if_stmt_1299_branch_req_0 : boolean;
  signal if_stmt_1299_branch_ack_0 : boolean;
  signal binary_1285_inst_req_1 : boolean;
  signal binary_1285_inst_ack_0 : boolean;
  signal call_stmt_1270_call_ack_0 : boolean;
  signal ptr_deref_1229_store_0_ack_1 : boolean;
  signal simple_obj_ref_1209_store_0_ack_1 : boolean;
  signal simple_obj_ref_1209_store_0_req_1 : boolean;
  signal simple_obj_ref_1209_store_0_ack_0 : boolean;
  signal simple_obj_ref_1209_store_0_req_0 : boolean;
  signal simple_obj_ref_1209_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_1209_gather_scatter_req_0 : boolean;
  signal phi_stmt_1254_req_0 : boolean;
  signal phi_stmt_1254_ack_0 : boolean;
  signal phi_stmt_1261_ack_0 : boolean;
  signal simple_obj_ref_1205_store_0_ack_1 : boolean;
  signal simple_obj_ref_1205_store_0_req_1 : boolean;
  signal simple_obj_ref_1235_load_0_req_1 : boolean;
  signal simple_obj_ref_1241_gather_scatter_req_0 : boolean;
  signal ptr_deref_1219_store_0_req_1 : boolean;
  signal ptr_deref_1219_store_0_ack_1 : boolean;
  signal binary_1280_inst_ack_1 : boolean;
  signal simple_obj_ref_1197_store_0_req_0 : boolean;
  signal call_stmt_1270_call_req_1 : boolean;
  signal simple_obj_ref_1197_store_0_ack_0 : boolean;
  signal simple_obj_ref_1241_gather_scatter_ack_0 : boolean;
  signal ptr_deref_1229_gather_scatter_req_0 : boolean;
  signal ptr_deref_1229_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_1197_store_0_req_1 : boolean;
  signal simple_obj_ref_1197_store_0_ack_1 : boolean;
  signal simple_obj_ref_1205_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_1235_load_0_req_0 : boolean;
  signal simple_obj_ref_1247_load_0_ack_1 : boolean;
  signal simple_obj_ref_1241_load_0_req_0 : boolean;
  signal simple_obj_ref_1249_inst_ack_0 : boolean;
  signal simple_obj_ref_1249_inst_req_0 : boolean;
  signal binary_1291_inst_req_1 : boolean;
  signal phi_stmt_1261_req_0 : boolean;
  signal binary_1285_inst_req_0 : boolean;
  signal phi_stmt_1261_req_1 : boolean;
  signal type_cast_1267_inst_ack_0 : boolean;
  signal type_cast_1267_inst_req_0 : boolean;
  signal phi_stmt_1254_req_1 : boolean;
  signal type_cast_1260_inst_ack_0 : boolean;
  signal type_cast_1260_inst_req_0 : boolean;
  signal simple_obj_ref_1306_inst_ack_0 : boolean;
  signal simple_obj_ref_1306_inst_req_0 : boolean;
  signal ptr_deref_1229_store_0_ack_0 : boolean;
  -- 
begin --  
  -- output port buffering assignments
  ret_val_x_x <= ret_val_x_x_buffer; 
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
  main_inner_CP_3580: Block -- control-path 
    signal cp_elements: BooleanArray(114 downto 0);
    -- 
  begin -- 
    cp_elements(0) <= start_req_symbol;
    start_ack_symbol <= cp_elements(97);
    finAckJoin: join2 port map(pred0 => fin_req_symbol, pred1 => cp_elements(97), symbol_out => fin_ack_symbol, clk => clk, reset => reset);
    cp_elements(1) <= cp_elements(45);
    call_stmt_1233_call_req_0 <= cp_elements(1);
    cp_elements(2) <= cp_elements(112);
    call_stmt_1270_call_req_0 <= cp_elements(2);
    cp_elements(3) <= cp_elements(87);
    cp_elements(4) <= OrReduce(cp_elements(94) & cp_elements(114));
    simple_obj_ref_1306_inst_req_0 <= cp_elements(4);
    cp_elements(5) <= cp_elements(0);
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
    simple_obj_ref_1197_gather_scatter_req_0 <= cp_elements(7);
    cp_elements(8) <= cp_elements(5);
    cp_elements(9) <= simple_obj_ref_1197_gather_scatter_ack_0;
    simple_obj_ref_1197_store_0_req_0 <= cp_elements(9);
    cp_elements(10) <= simple_obj_ref_1197_store_0_ack_0;
    simple_obj_ref_1197_store_0_req_1 <= cp_elements(10);
    cp_elements(11) <= simple_obj_ref_1197_store_0_ack_1;
    cp_elements(12) <= cp_elements(5);
    cpelement_group_13 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(12) & cp_elements(14));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(13),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_1201_gather_scatter_req_0 <= cp_elements(13);
    cp_elements(14) <= cp_elements(5);
    cp_elements(15) <= simple_obj_ref_1201_gather_scatter_ack_0;
    simple_obj_ref_1201_store_0_req_0 <= cp_elements(15);
    cp_elements(16) <= simple_obj_ref_1201_store_0_ack_0;
    simple_obj_ref_1201_store_0_req_1 <= cp_elements(16);
    cp_elements(17) <= simple_obj_ref_1201_store_0_ack_1;
    cp_elements(18) <= cp_elements(5);
    cpelement_group_19 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(18) & cp_elements(20));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(19),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_1205_gather_scatter_req_0 <= cp_elements(19);
    cp_elements(20) <= cp_elements(5);
    cp_elements(21) <= simple_obj_ref_1205_gather_scatter_ack_0;
    simple_obj_ref_1205_store_0_req_0 <= cp_elements(21);
    cp_elements(22) <= simple_obj_ref_1205_store_0_ack_0;
    simple_obj_ref_1205_store_0_req_1 <= cp_elements(22);
    cp_elements(23) <= simple_obj_ref_1205_store_0_ack_1;
    cp_elements(24) <= cp_elements(5);
    cpelement_group_25 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(24) & cp_elements(26));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(25),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    simple_obj_ref_1209_gather_scatter_req_0 <= cp_elements(25);
    cp_elements(26) <= cp_elements(5);
    cp_elements(27) <= simple_obj_ref_1209_gather_scatter_ack_0;
    simple_obj_ref_1209_store_0_req_0 <= cp_elements(27);
    cp_elements(28) <= simple_obj_ref_1209_store_0_ack_0;
    simple_obj_ref_1209_store_0_req_1 <= cp_elements(28);
    cp_elements(29) <= simple_obj_ref_1209_store_0_ack_1;
    cp_elements(30) <= cp_elements(5);
    cpelement_group_31 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(30) & cp_elements(33));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(31),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    ptr_deref_1219_gather_scatter_req_0 <= cp_elements(31);
    cp_elements(32) <= cp_elements(5);
    cp_elements(33) <= cp_elements(5);
    cp_elements(34) <= ptr_deref_1219_gather_scatter_ack_0;
    ptr_deref_1219_store_0_req_0 <= cp_elements(34);
    cp_elements(35) <= ptr_deref_1219_store_0_ack_0;
    cp_elements(36) <= cp_elements(35);
    ptr_deref_1219_store_0_req_1 <= cp_elements(36);
    cp_elements(37) <= ptr_deref_1219_store_0_ack_1;
    cp_elements(38) <= cp_elements(5);
    cpelement_group_39 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(35) & cp_elements(38) & cp_elements(41));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(39),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    ptr_deref_1229_gather_scatter_req_0 <= cp_elements(39);
    cp_elements(40) <= cp_elements(5);
    cp_elements(41) <= cp_elements(5);
    cp_elements(42) <= ptr_deref_1229_gather_scatter_ack_0;
    ptr_deref_1229_store_0_req_0 <= cp_elements(42);
    cp_elements(43) <= ptr_deref_1229_store_0_ack_0;
    ptr_deref_1229_store_0_req_1 <= cp_elements(43);
    cp_elements(44) <= ptr_deref_1229_store_0_ack_1;
    cpelement_group_45 : Block -- 
      signal predecessors: BooleanArray(7 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(11) & cp_elements(17) & cp_elements(23) & cp_elements(29) & cp_elements(32) & cp_elements(37) & cp_elements(40) & cp_elements(44));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(45),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(46) <= call_stmt_1233_call_ack_0;
    call_stmt_1233_call_req_1 <= cp_elements(46);
    cp_elements(47) <= call_stmt_1233_call_ack_1;
    simple_obj_ref_1235_load_0_req_0 <= cp_elements(47);
    cp_elements(48) <= simple_obj_ref_1235_load_0_ack_0;
    simple_obj_ref_1235_load_0_req_1 <= cp_elements(48);
    cp_elements(49) <= simple_obj_ref_1235_load_0_ack_1;
    simple_obj_ref_1235_gather_scatter_req_0 <= cp_elements(49);
    cp_elements(50) <= simple_obj_ref_1235_gather_scatter_ack_0;
    simple_obj_ref_1237_inst_req_0 <= cp_elements(50);
    cp_elements(51) <= simple_obj_ref_1237_inst_ack_0;
    simple_obj_ref_1241_load_0_req_0 <= cp_elements(51);
    cp_elements(52) <= simple_obj_ref_1241_load_0_ack_0;
    simple_obj_ref_1241_load_0_req_1 <= cp_elements(52);
    cp_elements(53) <= simple_obj_ref_1241_load_0_ack_1;
    simple_obj_ref_1241_gather_scatter_req_0 <= cp_elements(53);
    cp_elements(54) <= simple_obj_ref_1241_gather_scatter_ack_0;
    simple_obj_ref_1243_inst_req_0 <= cp_elements(54);
    cp_elements(55) <= simple_obj_ref_1243_inst_ack_0;
    simple_obj_ref_1247_load_0_req_0 <= cp_elements(55);
    cp_elements(56) <= simple_obj_ref_1247_load_0_ack_0;
    simple_obj_ref_1247_load_0_req_1 <= cp_elements(56);
    cp_elements(57) <= simple_obj_ref_1247_load_0_ack_1;
    simple_obj_ref_1247_gather_scatter_req_0 <= cp_elements(57);
    cp_elements(58) <= simple_obj_ref_1247_gather_scatter_ack_0;
    simple_obj_ref_1249_inst_req_0 <= cp_elements(58);
    cp_elements(59) <= simple_obj_ref_1249_inst_ack_0;
    cp_elements(60) <= call_stmt_1270_call_ack_0;
    call_stmt_1270_call_req_1 <= cp_elements(60);
    cp_elements(61) <= call_stmt_1270_call_ack_1;
    cp_elements(62) <= cp_elements(61);
    cpelement_group_63 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(64) & cp_elements(65));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(63),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1275_inst_req_0 <= cp_elements(63);
    cp_elements(64) <= cp_elements(62);
    cp_elements(65) <= cp_elements(62);
    cp_elements(66) <= binary_1275_inst_ack_0;
    binary_1275_inst_req_1 <= cp_elements(66);
    cp_elements(67) <= binary_1275_inst_ack_1;
    cpelement_group_68 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(67) & cp_elements(69) & cp_elements(70));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(68),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1280_inst_req_0 <= cp_elements(68);
    cp_elements(69) <= cp_elements(62);
    cp_elements(70) <= cp_elements(62);
    cp_elements(71) <= binary_1280_inst_ack_0;
    binary_1280_inst_req_1 <= cp_elements(71);
    cp_elements(72) <= binary_1280_inst_ack_1;
    cpelement_group_73 : Block -- 
      signal predecessors: BooleanArray(2 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(72) & cp_elements(74) & cp_elements(75));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(73),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1285_inst_req_0 <= cp_elements(73);
    cp_elements(74) <= cp_elements(62);
    cp_elements(75) <= cp_elements(62);
    cp_elements(76) <= binary_1285_inst_ack_0;
    binary_1285_inst_req_1 <= cp_elements(76);
    cp_elements(77) <= binary_1285_inst_ack_1;
    cpelement_group_78 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(79) & cp_elements(80));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(78),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1291_inst_req_0 <= cp_elements(78);
    cp_elements(79) <= cp_elements(62);
    cp_elements(80) <= cp_elements(62);
    cp_elements(81) <= binary_1291_inst_ack_0;
    binary_1291_inst_req_1 <= cp_elements(81);
    cp_elements(82) <= binary_1291_inst_ack_1;
    cpelement_group_83 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(82) & cp_elements(84));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(83),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    binary_1297_inst_req_0 <= cp_elements(83);
    cp_elements(84) <= cp_elements(62);
    cp_elements(85) <= binary_1297_inst_ack_0;
    binary_1297_inst_req_1 <= cp_elements(85);
    cp_elements(86) <= binary_1297_inst_ack_1;
    cpelement_group_87 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(77) & cp_elements(86));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(87),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(88) <= cp_elements(3);
    cp_elements(89) <= false;
    cp_elements(90) <= cp_elements(89);
    cp_elements(91) <= cp_elements(3);
    if_stmt_1299_branch_req_0 <= cp_elements(91);
    cp_elements(92) <= cp_elements(91);
    cp_elements(93) <= cp_elements(92);
    cp_elements(94) <= if_stmt_1299_branch_ack_1;
    cp_elements(95) <= cp_elements(92);
    cp_elements(96) <= if_stmt_1299_branch_ack_0;
    cp_elements(97) <= simple_obj_ref_1306_inst_ack_0;
    cp_elements(98) <= cp_elements(96);
    cp_elements(99) <= cp_elements(98);
    type_cast_1260_inst_req_0 <= cp_elements(99);
    cp_elements(100) <= type_cast_1260_inst_ack_0;
    phi_stmt_1254_req_1 <= cp_elements(100);
    cp_elements(101) <= cp_elements(98);
    type_cast_1267_inst_req_0 <= cp_elements(101);
    cp_elements(102) <= type_cast_1267_inst_ack_0;
    phi_stmt_1261_req_1 <= cp_elements(102);
    cpelement_group_103 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(100) & cp_elements(102));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(103),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(104) <= cp_elements(59);
    cp_elements(105) <= cp_elements(104);
    phi_stmt_1254_req_0 <= cp_elements(105);
    cp_elements(106) <= cp_elements(104);
    phi_stmt_1261_req_0 <= cp_elements(106);
    cpelement_group_107 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(105) & cp_elements(106));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(107),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(108) <= OrReduce(cp_elements(103) & cp_elements(107));
    cp_elements(109) <= cp_elements(108);
    cp_elements(110) <= phi_stmt_1254_ack_0;
    cp_elements(111) <= phi_stmt_1261_ack_0;
    cpelement_group_112 : Block -- 
      signal predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      predecessors <= (cp_elements(110) & cp_elements(111));
      jNoI: join -- 
        port map( -- 
          preds => predecessors,
          symbol_out => cp_elements(112),
          clk => clk,
          reset => reset); -- 
      -- 
    end Block;
    cp_elements(113) <= false;
    cp_elements(114) <= cp_elements(113);
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal Bx_xnot_1254 : std_logic_vector(31 downto 0);
    signal exitcond_1298 : std_logic_vector(0 downto 0);
    signal iNsTr_12_1242 : std_logic_vector(31 downto 0);
    signal iNsTr_15_1248 : std_logic_vector(31 downto 0);
    signal iNsTr_19_1270 : std_logic_vector(31 downto 0);
    signal iNsTr_20_1276 : std_logic_vector(31 downto 0);
    signal iNsTr_21_1281 : std_logic_vector(31 downto 0);
    signal iNsTr_4_1217 : std_logic_vector(31 downto 0);
    signal iNsTr_6_1227 : std_logic_vector(31 downto 0);
    signal iNsTr_9_1236 : std_logic_vector(31 downto 0);
    signal indvarx_xnext_1292 : std_logic_vector(31 downto 0);
    signal outx_x01_1261 : std_logic_vector(31 downto 0);
    signal ptr_deref_1219_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_1219_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_1219_word_address_0 : std_logic_vector(1 downto 0);
    signal ptr_deref_1229_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_1229_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_1229_word_address_0 : std_logic_vector(1 downto 0);
    signal simple_obj_ref_1197_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_1197_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_1201_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_1201_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_1205_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_1205_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_1209_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_1209_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_1235_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_1235_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_1241_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_1241_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_1247_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_1247_word_address_0 : std_logic_vector(0 downto 0);
    signal type_cast_1199_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1203_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1207_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1211_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1221_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1231_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1258_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1260_wire : std_logic_vector(31 downto 0);
    signal type_cast_1265_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1267_wire : std_logic_vector(31 downto 0);
    signal type_cast_1274_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1290_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_1296_wire_constant : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    iNsTr_4_1217 <= "00000000000000000000000000000000";
    iNsTr_6_1227 <= "00000000000000000000000000000001";
    ptr_deref_1219_word_address_0 <= "00";
    ptr_deref_1229_word_address_0 <= "01";
    simple_obj_ref_1197_word_address_0 <= "0";
    simple_obj_ref_1201_word_address_0 <= "0";
    simple_obj_ref_1205_word_address_0 <= "0";
    simple_obj_ref_1209_word_address_0 <= "0";
    simple_obj_ref_1235_word_address_0 <= "0";
    simple_obj_ref_1241_word_address_0 <= "0";
    simple_obj_ref_1247_word_address_0 <= "0";
    type_cast_1199_wire_constant <= "00000000000000000000000000000000";
    type_cast_1203_wire_constant <= "00000000000000000000000000000000";
    type_cast_1207_wire_constant <= "00000000000000000000000000000000";
    type_cast_1211_wire_constant <= "00000000000000000000000000000000";
    type_cast_1221_wire_constant <= "11111111111111111111111111111111";
    type_cast_1231_wire_constant <= "11111111111111111111111111111111";
    type_cast_1258_wire_constant <= "00000000000000000000000000000000";
    type_cast_1265_wire_constant <= "00000000000000000000000000000000";
    type_cast_1274_wire_constant <= "00000000000000000000000000011111";
    type_cast_1290_wire_constant <= "00000000000000000000000000000001";
    type_cast_1296_wire_constant <= "00000000000000000000000000100000";
    phi_stmt_1254: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_1258_wire_constant & type_cast_1260_wire;
      req <= phi_stmt_1254_req_0 & phi_stmt_1254_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_1254_ack_0,
          idata => idata,
          odata => Bx_xnot_1254,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_1254
    phi_stmt_1261: Block -- phi operator 
      signal idata: std_logic_vector(63 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_1265_wire_constant & type_cast_1267_wire;
      req <= phi_stmt_1261_req_0 & phi_stmt_1261_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 32) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_1261_ack_0,
          idata => idata,
          odata => outx_x01_1261,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_1261
    type_cast_1260_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => indvarx_xnext_1292, dout => type_cast_1260_wire, req => type_cast_1260_inst_req_0, ack => type_cast_1260_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_1267_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => ret_val_x_x_buffer, dout => type_cast_1267_wire, req => type_cast_1267_inst_req_0, ack => type_cast_1267_inst_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_1219_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_1219_gather_scatter_ack_0 <= ptr_deref_1219_gather_scatter_req_0;
      aggregated_sig <= type_cast_1221_wire_constant;
      ptr_deref_1219_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_1229_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_1229_gather_scatter_ack_0 <= ptr_deref_1229_gather_scatter_req_0;
      aggregated_sig <= type_cast_1231_wire_constant;
      ptr_deref_1229_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_1197_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_1197_gather_scatter_ack_0 <= simple_obj_ref_1197_gather_scatter_req_0;
      aggregated_sig <= type_cast_1199_wire_constant;
      simple_obj_ref_1197_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_1201_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_1201_gather_scatter_ack_0 <= simple_obj_ref_1201_gather_scatter_req_0;
      aggregated_sig <= type_cast_1203_wire_constant;
      simple_obj_ref_1201_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_1205_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_1205_gather_scatter_ack_0 <= simple_obj_ref_1205_gather_scatter_req_0;
      aggregated_sig <= type_cast_1207_wire_constant;
      simple_obj_ref_1205_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_1209_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_1209_gather_scatter_ack_0 <= simple_obj_ref_1209_gather_scatter_req_0;
      aggregated_sig <= type_cast_1211_wire_constant;
      simple_obj_ref_1209_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_1235_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_1235_gather_scatter_ack_0 <= simple_obj_ref_1235_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_1235_data_0;
      iNsTr_9_1236 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_1241_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_1241_gather_scatter_ack_0 <= simple_obj_ref_1241_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_1241_data_0;
      iNsTr_12_1242 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_1247_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_1247_gather_scatter_ack_0 <= simple_obj_ref_1247_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_1247_data_0;
      iNsTr_15_1248 <= aggregated_sig(31 downto 0);
      --
    end Block;
    if_stmt_1299_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= exitcond_1298;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_1299_branch_req_0,
          ack0 => if_stmt_1299_branch_ack_0,
          ack1 => if_stmt_1299_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : binary_1275_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= Bx_xnot_1254;
      iNsTr_20_1276 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntXor",
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
          constant_operand => "00000000000000000000000000011111",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1275_inst_req_0,
          ackL => binary_1275_inst_ack_0,
          reqR => binary_1275_inst_req_1,
          ackR => binary_1275_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : binary_1280_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_19_1270 & iNsTr_20_1276;
      iNsTr_21_1281 <= data_out(31 downto 0);
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
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1280_inst_req_0,
          ackL => binary_1280_inst_ack_0,
          reqR => binary_1280_inst_req_1,
          ackR => binary_1280_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : binary_1285_inst 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_21_1281 & outx_x01_1261;
      ret_val_x_x_buffer <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
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
          reqL => binary_1285_inst_req_0,
          ackL => binary_1285_inst_ack_0,
          reqR => binary_1285_inst_req_1,
          ackR => binary_1285_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : binary_1291_inst 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= Bx_xnot_1254;
      indvarx_xnext_1292 <= data_out(31 downto 0);
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
          reqL => binary_1291_inst_req_0,
          ackL => binary_1291_inst_ack_0,
          reqR => binary_1291_inst_req_1,
          ackR => binary_1291_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : binary_1297_inst 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= indvarx_xnext_1292;
      exitcond_1298 <= data_out(0 downto 0);
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
          constant_operand => "00000000000000000000000000100000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_1297_inst_req_0,
          ackL => binary_1297_inst_ack_0,
          reqR => binary_1297_inst_req_1,
          ackR => binary_1297_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared load operator group (0) : simple_obj_ref_1235_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_1235_load_0_req_0;
      simple_obj_ref_1235_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_1235_load_0_req_1;
      simple_obj_ref_1235_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_1235_word_address_0;
      simple_obj_ref_1235_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 2, min_clock_period => true,
        no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(0),
          mack => memory_space_0_lr_ack(0),
          maddr => memory_space_0_lr_addr(0 downto 0),
          mtag => memory_space_0_lr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(0),
          mack => memory_space_0_lc_ack(0),
          mdata => memory_space_0_lc_data(31 downto 0),
          mtag => memory_space_0_lc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- shared load operator group (1) : simple_obj_ref_1241_load_0 
    LoadGroup1: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_1241_load_0_req_0;
      simple_obj_ref_1241_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_1241_load_0_req_1;
      simple_obj_ref_1241_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_1241_word_address_0;
      simple_obj_ref_1241_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 2, min_clock_period => true,
        no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_1_lr_req(0),
          mack => memory_space_1_lr_ack(0),
          maddr => memory_space_1_lr_addr(0 downto 0),
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
    end Block; -- load group 1
    -- shared load operator group (2) : simple_obj_ref_1247_load_0 
    LoadGroup2: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_1247_load_0_req_0;
      simple_obj_ref_1247_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_1247_load_0_req_1;
      simple_obj_ref_1247_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_1247_word_address_0;
      simple_obj_ref_1247_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 2, min_clock_period => true,
        no_arbitration => true)
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
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
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
    end Block; -- load group 2
    -- shared store operator group (0) : ptr_deref_1219_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(1 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_1219_store_0_req_0;
      ptr_deref_1219_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_1219_store_0_req_1;
      ptr_deref_1219_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_1219_word_address_0;
      data_in <= ptr_deref_1219_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 2,
        data_width => 32,
        num_reqs => 1,
        tag_length => 1,
        min_clock_period => true,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_3_sr_req(1),
          mack => memory_space_3_sr_ack(1),
          maddr => memory_space_3_sr_addr(3 downto 2),
          mdata => memory_space_3_sr_data(63 downto 32),
          mtag => memory_space_3_sr_tag(1 downto 1),
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
          mreq => memory_space_3_sc_req(1),
          mack => memory_space_3_sc_ack(1),
          mtag => memory_space_3_sc_tag(1 downto 1),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 0
    -- shared store operator group (1) : ptr_deref_1229_store_0 
    StoreGroup1: Block -- 
      signal addr_in: std_logic_vector(1 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_1229_store_0_req_0;
      ptr_deref_1229_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_1229_store_0_req_1;
      ptr_deref_1229_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_1229_word_address_0;
      data_in <= ptr_deref_1229_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 2,
        data_width => 32,
        num_reqs => 1,
        tag_length => 1,
        min_clock_period => true,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_3_sr_req(0),
          mack => memory_space_3_sr_ack(0),
          maddr => memory_space_3_sr_addr(1 downto 0),
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
    -- shared store operator group (2) : simple_obj_ref_1197_store_0 
    StoreGroup2: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_1197_store_0_req_0;
      simple_obj_ref_1197_store_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_1197_store_0_req_1;
      simple_obj_ref_1197_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_1197_word_address_0;
      data_in <= simple_obj_ref_1197_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 2,
        min_clock_period => true,
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
          num_reqs => 1,
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
    -- shared store operator group (3) : simple_obj_ref_1201_store_0 
    StoreGroup3: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_1201_store_0_req_0;
      simple_obj_ref_1201_store_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_1201_store_0_req_1;
      simple_obj_ref_1201_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_1201_word_address_0;
      data_in <= simple_obj_ref_1201_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 2,
        min_clock_period => true,
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
    end Block; -- store group 3
    -- shared store operator group (4) : simple_obj_ref_1205_store_0 
    StoreGroup4: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_1205_store_0_req_0;
      simple_obj_ref_1205_store_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_1205_store_0_req_1;
      simple_obj_ref_1205_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_1205_word_address_0;
      data_in <= simple_obj_ref_1205_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 2,
        min_clock_period => true,
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
    end Block; -- store group 4
    -- shared store operator group (5) : simple_obj_ref_1209_store_0 
    StoreGroup5: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_1209_store_0_req_0;
      simple_obj_ref_1209_store_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_1209_store_0_req_1;
      simple_obj_ref_1209_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_1209_word_address_0;
      data_in <= simple_obj_ref_1209_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 1,
        min_clock_period => true,
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
    end Block; -- store group 5
    -- shared outport operator group (0) : simple_obj_ref_1237_inst simple_obj_ref_1243_inst simple_obj_ref_1249_inst simple_obj_ref_1306_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(127 downto 0);
      signal req, ack : BooleanArray( 3 downto 0);
      -- 
    begin -- 
      req(3) <= simple_obj_ref_1237_inst_req_0;
      req(2) <= simple_obj_ref_1243_inst_req_0;
      req(1) <= simple_obj_ref_1249_inst_req_0;
      req(0) <= simple_obj_ref_1306_inst_req_0;
      simple_obj_ref_1237_inst_ack_0 <= ack(3);
      simple_obj_ref_1243_inst_ack_0 <= ack(2);
      simple_obj_ref_1249_inst_ack_0 <= ack(1);
      simple_obj_ref_1306_inst_ack_0 <= ack(0);
      data_in <= iNsTr_9_1236 & iNsTr_12_1242 & iNsTr_15_1248 & ret_val_x_x_buffer;
      outport: OutputPort -- 
        generic map ( data_width => 32,  num_reqs => 4,  no_arbitration => true)
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
    -- shared call operator group (0) : call_stmt_1233_call 
    CallGroup0: Block -- 
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= call_stmt_1233_call_req_0;
      call_stmt_1233_call_ack_0 <= ackL(0);
      reqR(0) <= call_stmt_1233_call_req_1;
      call_stmt_1233_call_ack_1 <= ackR(0);
      CallReq: InputMuxBaseNoData -- 
        generic map (  twidth => 1, nreqs => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          reqR => a5init_call_reqs(0),
          ackR => a5init_call_acks(0),
          tagR => a5init_call_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      CallComplete: OutputDemuxBaseNoData -- 
        generic map ( 
        twidth => 1, nreqs => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          reqL => a5init_return_acks(0), -- cross-over
          ackL => a5init_return_reqs(0), -- cross-over
          tagL => a5init_return_tag(0 downto 0),
          clk => clk,
          reset => reset -- 
        ); -- 
      -- 
    end Block; -- call group 0
    -- shared call operator group (1) : call_stmt_1270_call 
    CallGroup1: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= call_stmt_1270_call_req_0;
      call_stmt_1270_call_ack_0 <= ackL(0);
      reqR(0) <= call_stmt_1270_call_req_1;
      call_stmt_1270_call_ack_1 <= ackR(0);
      iNsTr_19_1270 <= data_out(31 downto 0);
      CallReq: InputMuxBaseNoData -- 
        generic map (  twidth => 1, nreqs => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          reqR => a5reg_call_reqs(0),
          ackR => a5reg_call_acks(0),
          tagR => a5reg_call_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      CallComplete: OutputDemuxBase -- 
        generic map ( 
        iwidth => 32, owidth => 32, twidth => 1, nreqs => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          reqL => a5reg_return_acks(0), -- cross-over
          ackL => a5reg_return_reqs(0), -- cross-over
          dataL => a5reg_return_data(31 downto 0),
          tagL => a5reg_return_tag(0 downto 0),
          clk => clk,
          reset => reset -- 
        ); -- 
      -- 
    end Block; -- call group 1
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
    main_inner_ret_val_x_x : out  std_logic_vector(31 downto 0);
    main_inner_tag_in: in std_logic_vector(0 downto 0);
    main_inner_tag_out: out std_logic_vector(0 downto 0);
    main_inner_start_req : in std_logic;
    main_inner_start_ack : out std_logic;
    main_inner_fin_req   : in std_logic;
    main_inner_fin_ack   : out std_logic;
    clk : in std_logic;
    reset : in std_logic;
    outpipe_pipe_read_data: out std_logic_vector(31 downto 0);
    outpipe_pipe_read_req : in std_logic_vector(0 downto 0);
    outpipe_pipe_read_ack : out std_logic_vector(0 downto 0)); -- 
  -- 
end entity; 
architecture Default of ahir_system is -- system-architecture 
  -- interface signals to connect to memory space memory_space_0
  signal memory_space_0_lr_req :  std_logic_vector(2 downto 0);
  signal memory_space_0_lr_ack : std_logic_vector(2 downto 0);
  signal memory_space_0_lr_addr : std_logic_vector(2 downto 0);
  signal memory_space_0_lr_tag : std_logic_vector(5 downto 0);
  signal memory_space_0_lc_req : std_logic_vector(2 downto 0);
  signal memory_space_0_lc_ack :  std_logic_vector(2 downto 0);
  signal memory_space_0_lc_data : std_logic_vector(95 downto 0);
  signal memory_space_0_lc_tag :  std_logic_vector(5 downto 0);
  signal memory_space_0_sr_req :  std_logic_vector(2 downto 0);
  signal memory_space_0_sr_ack : std_logic_vector(2 downto 0);
  signal memory_space_0_sr_addr : std_logic_vector(2 downto 0);
  signal memory_space_0_sr_data : std_logic_vector(95 downto 0);
  signal memory_space_0_sr_tag : std_logic_vector(5 downto 0);
  signal memory_space_0_sc_req : std_logic_vector(2 downto 0);
  signal memory_space_0_sc_ack :  std_logic_vector(2 downto 0);
  signal memory_space_0_sc_tag :  std_logic_vector(5 downto 0);
  -- interface signals to connect to memory space memory_space_1
  signal memory_space_1_lr_req :  std_logic_vector(2 downto 0);
  signal memory_space_1_lr_ack : std_logic_vector(2 downto 0);
  signal memory_space_1_lr_addr : std_logic_vector(2 downto 0);
  signal memory_space_1_lr_tag : std_logic_vector(5 downto 0);
  signal memory_space_1_lc_req : std_logic_vector(2 downto 0);
  signal memory_space_1_lc_ack :  std_logic_vector(2 downto 0);
  signal memory_space_1_lc_data : std_logic_vector(95 downto 0);
  signal memory_space_1_lc_tag :  std_logic_vector(5 downto 0);
  signal memory_space_1_sr_req :  std_logic_vector(2 downto 0);
  signal memory_space_1_sr_ack : std_logic_vector(2 downto 0);
  signal memory_space_1_sr_addr : std_logic_vector(2 downto 0);
  signal memory_space_1_sr_data : std_logic_vector(95 downto 0);
  signal memory_space_1_sr_tag : std_logic_vector(5 downto 0);
  signal memory_space_1_sc_req : std_logic_vector(2 downto 0);
  signal memory_space_1_sc_ack :  std_logic_vector(2 downto 0);
  signal memory_space_1_sc_tag :  std_logic_vector(5 downto 0);
  -- interface signals to connect to memory space memory_space_2
  signal memory_space_2_lr_req :  std_logic_vector(2 downto 0);
  signal memory_space_2_lr_ack : std_logic_vector(2 downto 0);
  signal memory_space_2_lr_addr : std_logic_vector(2 downto 0);
  signal memory_space_2_lr_tag : std_logic_vector(5 downto 0);
  signal memory_space_2_lc_req : std_logic_vector(2 downto 0);
  signal memory_space_2_lc_ack :  std_logic_vector(2 downto 0);
  signal memory_space_2_lc_data : std_logic_vector(95 downto 0);
  signal memory_space_2_lc_tag :  std_logic_vector(5 downto 0);
  signal memory_space_2_sr_req :  std_logic_vector(2 downto 0);
  signal memory_space_2_sr_ack : std_logic_vector(2 downto 0);
  signal memory_space_2_sr_addr : std_logic_vector(2 downto 0);
  signal memory_space_2_sr_data : std_logic_vector(95 downto 0);
  signal memory_space_2_sr_tag : std_logic_vector(5 downto 0);
  signal memory_space_2_sc_req : std_logic_vector(2 downto 0);
  signal memory_space_2_sc_ack :  std_logic_vector(2 downto 0);
  signal memory_space_2_sc_tag :  std_logic_vector(5 downto 0);
  -- interface signals to connect to memory space memory_space_3
  signal memory_space_3_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_3_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_3_lr_addr : std_logic_vector(1 downto 0);
  signal memory_space_3_lr_tag : std_logic_vector(0 downto 0);
  signal memory_space_3_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_3_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_3_lc_data : std_logic_vector(31 downto 0);
  signal memory_space_3_lc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_3_sr_req :  std_logic_vector(1 downto 0);
  signal memory_space_3_sr_ack : std_logic_vector(1 downto 0);
  signal memory_space_3_sr_addr : std_logic_vector(3 downto 0);
  signal memory_space_3_sr_data : std_logic_vector(63 downto 0);
  signal memory_space_3_sr_tag : std_logic_vector(1 downto 0);
  signal memory_space_3_sc_req : std_logic_vector(1 downto 0);
  signal memory_space_3_sc_ack :  std_logic_vector(1 downto 0);
  signal memory_space_3_sc_tag :  std_logic_vector(1 downto 0);
  -- interface signals to connect to memory space memory_space_4
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
  -- declarations related to module a5init
  component a5init is -- 
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
      memory_space_2_lr_addr : out  std_logic_vector(0 downto 0);
      memory_space_2_lr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_2_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_2_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_2_lc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_0_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_0_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_lr_addr : out  std_logic_vector(0 downto 0);
      memory_space_0_lr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_0_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_0_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_0_lc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_1_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_1_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_lr_addr : out  std_logic_vector(0 downto 0);
      memory_space_1_lr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_1_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_1_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_1_lc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_3_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_3_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_3_lr_addr : out  std_logic_vector(1 downto 0);
      memory_space_3_lr_tag :  out  std_logic_vector(0 downto 0);
      memory_space_3_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_3_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_3_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_3_lc_tag :  in  std_logic_vector(0 downto 0);
      memory_space_4_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_4_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_4_lr_addr : out  std_logic_vector(0 downto 0);
      memory_space_4_lr_tag :  out  std_logic_vector(0 downto 0);
      memory_space_4_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_4_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_4_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_4_lc_tag :  in  std_logic_vector(0 downto 0);
      memory_space_2_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_2_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_sr_addr : out  std_logic_vector(0 downto 0);
      memory_space_2_sr_data : out  std_logic_vector(31 downto 0);
      memory_space_2_sr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_2_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_2_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_sc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_0_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_0_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_sr_addr : out  std_logic_vector(0 downto 0);
      memory_space_0_sr_data : out  std_logic_vector(31 downto 0);
      memory_space_0_sr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_0_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_0_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_sc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_1_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_1_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_sr_addr : out  std_logic_vector(0 downto 0);
      memory_space_1_sr_data : out  std_logic_vector(31 downto 0);
      memory_space_1_sr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_1_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_1_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_sc_tag :  in  std_logic_vector(1 downto 0);
      a5reg_call_reqs : out  std_logic_vector(0 downto 0);
      a5reg_call_acks : in   std_logic_vector(0 downto 0);
      a5reg_call_tag  :  out  std_logic_vector(0 downto 0);
      a5reg_return_reqs : out  std_logic_vector(0 downto 0);
      a5reg_return_acks : in   std_logic_vector(0 downto 0);
      a5reg_return_data : in   std_logic_vector(31 downto 0);
      a5reg_return_tag :  in   std_logic_vector(0 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
    -- 
  end component;
  -- argument signals for module a5init
  signal a5init_tag_in    : std_logic_vector(0 downto 0) := (others => '0');
  signal a5init_tag_out   : std_logic_vector(0 downto 0);
  signal a5init_start_req : std_logic;
  signal a5init_start_ack : std_logic;
  signal a5init_fin_req   : std_logic;
  signal a5init_fin_ack : std_logic;
  -- caller side aggregated signals for module a5init
  signal a5init_call_reqs: std_logic_vector(0 downto 0);
  signal a5init_call_acks: std_logic_vector(0 downto 0);
  signal a5init_return_reqs: std_logic_vector(0 downto 0);
  signal a5init_return_acks: std_logic_vector(0 downto 0);
  signal a5init_call_tag: std_logic_vector(0 downto 0);
  signal a5init_return_tag: std_logic_vector(0 downto 0);
  -- declarations related to module a5reg
  component a5reg is -- 
    generic (tag_length : integer); 
    port ( -- 
      ret_val_x_x : out  std_logic_vector(31 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic;
      memory_space_2_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_2_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_lr_addr : out  std_logic_vector(0 downto 0);
      memory_space_2_lr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_2_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_2_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_2_lc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_0_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_0_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_lr_addr : out  std_logic_vector(0 downto 0);
      memory_space_0_lr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_0_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_0_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_0_lc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_1_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_1_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_lr_addr : out  std_logic_vector(0 downto 0);
      memory_space_1_lr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_1_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_1_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_1_lc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_2_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_2_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_sr_addr : out  std_logic_vector(0 downto 0);
      memory_space_2_sr_data : out  std_logic_vector(31 downto 0);
      memory_space_2_sr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_2_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_2_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_sc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_0_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_0_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_sr_addr : out  std_logic_vector(0 downto 0);
      memory_space_0_sr_data : out  std_logic_vector(31 downto 0);
      memory_space_0_sr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_0_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_0_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_sc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_1_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_1_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_sr_addr : out  std_logic_vector(0 downto 0);
      memory_space_1_sr_data : out  std_logic_vector(31 downto 0);
      memory_space_1_sr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_1_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_1_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_sc_tag :  in  std_logic_vector(1 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
    -- 
  end component;
  -- argument signals for module a5reg
  signal a5reg_ret_val_x_x :  std_logic_vector(31 downto 0);
  signal a5reg_out_args   : std_logic_vector(31 downto 0);
  signal a5reg_tag_in    : std_logic_vector(1 downto 0) := (others => '0');
  signal a5reg_tag_out   : std_logic_vector(1 downto 0);
  signal a5reg_start_req : std_logic;
  signal a5reg_start_ack : std_logic;
  signal a5reg_fin_req   : std_logic;
  signal a5reg_fin_ack : std_logic;
  -- caller side aggregated signals for module a5reg
  signal a5reg_call_reqs: std_logic_vector(1 downto 0);
  signal a5reg_call_acks: std_logic_vector(1 downto 0);
  signal a5reg_return_reqs: std_logic_vector(1 downto 0);
  signal a5reg_return_acks: std_logic_vector(1 downto 0);
  signal a5reg_call_tag: std_logic_vector(1 downto 0);
  signal a5reg_return_data: std_logic_vector(63 downto 0);
  signal a5reg_return_tag: std_logic_vector(1 downto 0);
  -- declarations related to module main_inner
  component main_inner is -- 
    generic (tag_length : integer); 
    port ( -- 
      ret_val_x_x : out  std_logic_vector(31 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic;
      memory_space_2_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_2_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_lr_addr : out  std_logic_vector(0 downto 0);
      memory_space_2_lr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_2_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_2_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_2_lc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_0_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_0_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_lr_addr : out  std_logic_vector(0 downto 0);
      memory_space_0_lr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_0_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_0_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_0_lc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_1_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_1_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_lr_addr : out  std_logic_vector(0 downto 0);
      memory_space_1_lr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_1_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_1_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_1_lc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_2_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_2_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_sr_addr : out  std_logic_vector(0 downto 0);
      memory_space_2_sr_data : out  std_logic_vector(31 downto 0);
      memory_space_2_sr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_2_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_2_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_sc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_0_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_0_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_sr_addr : out  std_logic_vector(0 downto 0);
      memory_space_0_sr_data : out  std_logic_vector(31 downto 0);
      memory_space_0_sr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_0_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_0_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_sc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_1_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_1_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_sr_addr : out  std_logic_vector(0 downto 0);
      memory_space_1_sr_data : out  std_logic_vector(31 downto 0);
      memory_space_1_sr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_1_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_1_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_sc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_3_sr_req : out  std_logic_vector(1 downto 0);
      memory_space_3_sr_ack : in   std_logic_vector(1 downto 0);
      memory_space_3_sr_addr : out  std_logic_vector(3 downto 0);
      memory_space_3_sr_data : out  std_logic_vector(63 downto 0);
      memory_space_3_sr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_3_sc_req : out  std_logic_vector(1 downto 0);
      memory_space_3_sc_ack : in   std_logic_vector(1 downto 0);
      memory_space_3_sc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_4_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_4_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_4_sr_addr : out  std_logic_vector(0 downto 0);
      memory_space_4_sr_data : out  std_logic_vector(31 downto 0);
      memory_space_4_sr_tag :  out  std_logic_vector(0 downto 0);
      memory_space_4_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_4_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_4_sc_tag :  in  std_logic_vector(0 downto 0);
      outpipe_pipe_write_req : out  std_logic_vector(0 downto 0);
      outpipe_pipe_write_ack : in   std_logic_vector(0 downto 0);
      outpipe_pipe_write_data : out  std_logic_vector(31 downto 0);
      a5reg_call_reqs : out  std_logic_vector(0 downto 0);
      a5reg_call_acks : in   std_logic_vector(0 downto 0);
      a5reg_call_tag  :  out  std_logic_vector(0 downto 0);
      a5reg_return_reqs : out  std_logic_vector(0 downto 0);
      a5reg_return_acks : in   std_logic_vector(0 downto 0);
      a5reg_return_data : in   std_logic_vector(31 downto 0);
      a5reg_return_tag :  in   std_logic_vector(0 downto 0);
      a5init_call_reqs : out  std_logic_vector(0 downto 0);
      a5init_call_acks : in   std_logic_vector(0 downto 0);
      a5init_call_tag  :  out  std_logic_vector(0 downto 0);
      a5init_return_reqs : out  std_logic_vector(0 downto 0);
      a5init_return_acks : in   std_logic_vector(0 downto 0);
      a5init_return_tag :  in   std_logic_vector(0 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
    -- 
  end component;
  -- aggregate signals for write to pipe outpipe
  signal outpipe_pipe_write_data: std_logic_vector(31 downto 0);
  signal outpipe_pipe_write_req: std_logic_vector(0 downto 0);
  signal outpipe_pipe_write_ack: std_logic_vector(0 downto 0);
  -- 
begin -- 
  -- module a5init
  -- call arbiter for module a5init
  a5init_arbiter: SplitCallArbiterNoInargsNoOutargs -- 
    generic map( --
      num_reqs => 1,
      callee_tag_length => 1,
      caller_tag_length => 1--
    )
    port map(-- 
      call_reqs => a5init_call_reqs,
      call_acks => a5init_call_acks,
      return_reqs => a5init_return_reqs,
      return_acks => a5init_return_acks,
      call_tag  => a5init_call_tag,
      return_tag  => a5init_return_tag,
      call_mtag => a5init_tag_in,
      return_mtag => a5init_tag_out,
      call_mreq => a5init_start_req,
      call_mack => a5init_start_ack,
      return_mreq => a5init_fin_req,
      return_mack => a5init_fin_ack,
      clk => clk, 
      reset => reset --
    ); --
  a5init_instance:a5init-- 
    generic map(tag_length => 1)
    port map(-- 
      start_req => a5init_start_req,
      start_ack => a5init_start_ack,
      fin_req => a5init_fin_req,
      fin_ack => a5init_fin_ack,
      clk => clk,
      reset => reset,
      memory_space_0_lr_req => memory_space_0_lr_req(1 downto 1),
      memory_space_0_lr_ack => memory_space_0_lr_ack(1 downto 1),
      memory_space_0_lr_addr => memory_space_0_lr_addr(1 downto 1),
      memory_space_0_lr_tag => memory_space_0_lr_tag(3 downto 2),
      memory_space_0_lc_req => memory_space_0_lc_req(1 downto 1),
      memory_space_0_lc_ack => memory_space_0_lc_ack(1 downto 1),
      memory_space_0_lc_data => memory_space_0_lc_data(63 downto 32),
      memory_space_0_lc_tag => memory_space_0_lc_tag(3 downto 2),
      memory_space_1_lr_req => memory_space_1_lr_req(1 downto 1),
      memory_space_1_lr_ack => memory_space_1_lr_ack(1 downto 1),
      memory_space_1_lr_addr => memory_space_1_lr_addr(1 downto 1),
      memory_space_1_lr_tag => memory_space_1_lr_tag(3 downto 2),
      memory_space_1_lc_req => memory_space_1_lc_req(1 downto 1),
      memory_space_1_lc_ack => memory_space_1_lc_ack(1 downto 1),
      memory_space_1_lc_data => memory_space_1_lc_data(63 downto 32),
      memory_space_1_lc_tag => memory_space_1_lc_tag(3 downto 2),
      memory_space_2_lr_req => memory_space_2_lr_req(1 downto 1),
      memory_space_2_lr_ack => memory_space_2_lr_ack(1 downto 1),
      memory_space_2_lr_addr => memory_space_2_lr_addr(1 downto 1),
      memory_space_2_lr_tag => memory_space_2_lr_tag(3 downto 2),
      memory_space_2_lc_req => memory_space_2_lc_req(1 downto 1),
      memory_space_2_lc_ack => memory_space_2_lc_ack(1 downto 1),
      memory_space_2_lc_data => memory_space_2_lc_data(63 downto 32),
      memory_space_2_lc_tag => memory_space_2_lc_tag(3 downto 2),
      memory_space_3_lr_req => memory_space_3_lr_req(0 downto 0),
      memory_space_3_lr_ack => memory_space_3_lr_ack(0 downto 0),
      memory_space_3_lr_addr => memory_space_3_lr_addr(1 downto 0),
      memory_space_3_lr_tag => memory_space_3_lr_tag(0 downto 0),
      memory_space_3_lc_req => memory_space_3_lc_req(0 downto 0),
      memory_space_3_lc_ack => memory_space_3_lc_ack(0 downto 0),
      memory_space_3_lc_data => memory_space_3_lc_data(31 downto 0),
      memory_space_3_lc_tag => memory_space_3_lc_tag(0 downto 0),
      memory_space_4_lr_req => memory_space_4_lr_req(0 downto 0),
      memory_space_4_lr_ack => memory_space_4_lr_ack(0 downto 0),
      memory_space_4_lr_addr => memory_space_4_lr_addr(0 downto 0),
      memory_space_4_lr_tag => memory_space_4_lr_tag(0 downto 0),
      memory_space_4_lc_req => memory_space_4_lc_req(0 downto 0),
      memory_space_4_lc_ack => memory_space_4_lc_ack(0 downto 0),
      memory_space_4_lc_data => memory_space_4_lc_data(31 downto 0),
      memory_space_4_lc_tag => memory_space_4_lc_tag(0 downto 0),
      memory_space_0_sr_req => memory_space_0_sr_req(1 downto 1),
      memory_space_0_sr_ack => memory_space_0_sr_ack(1 downto 1),
      memory_space_0_sr_addr => memory_space_0_sr_addr(1 downto 1),
      memory_space_0_sr_data => memory_space_0_sr_data(63 downto 32),
      memory_space_0_sr_tag => memory_space_0_sr_tag(3 downto 2),
      memory_space_0_sc_req => memory_space_0_sc_req(1 downto 1),
      memory_space_0_sc_ack => memory_space_0_sc_ack(1 downto 1),
      memory_space_0_sc_tag => memory_space_0_sc_tag(3 downto 2),
      memory_space_1_sr_req => memory_space_1_sr_req(1 downto 1),
      memory_space_1_sr_ack => memory_space_1_sr_ack(1 downto 1),
      memory_space_1_sr_addr => memory_space_1_sr_addr(1 downto 1),
      memory_space_1_sr_data => memory_space_1_sr_data(63 downto 32),
      memory_space_1_sr_tag => memory_space_1_sr_tag(3 downto 2),
      memory_space_1_sc_req => memory_space_1_sc_req(1 downto 1),
      memory_space_1_sc_ack => memory_space_1_sc_ack(1 downto 1),
      memory_space_1_sc_tag => memory_space_1_sc_tag(3 downto 2),
      memory_space_2_sr_req => memory_space_2_sr_req(1 downto 1),
      memory_space_2_sr_ack => memory_space_2_sr_ack(1 downto 1),
      memory_space_2_sr_addr => memory_space_2_sr_addr(1 downto 1),
      memory_space_2_sr_data => memory_space_2_sr_data(63 downto 32),
      memory_space_2_sr_tag => memory_space_2_sr_tag(3 downto 2),
      memory_space_2_sc_req => memory_space_2_sc_req(1 downto 1),
      memory_space_2_sc_ack => memory_space_2_sc_ack(1 downto 1),
      memory_space_2_sc_tag => memory_space_2_sc_tag(3 downto 2),
      a5reg_call_reqs => a5reg_call_reqs(1 downto 1),
      a5reg_call_acks => a5reg_call_acks(1 downto 1),
      a5reg_call_tag => a5reg_call_tag(1 downto 1),
      a5reg_return_reqs => a5reg_return_reqs(1 downto 1),
      a5reg_return_acks => a5reg_return_acks(1 downto 1),
      a5reg_return_data => a5reg_return_data(63 downto 32),
      a5reg_return_tag => a5reg_return_tag(1 downto 1),
      tag_in => a5init_tag_in,
      tag_out => a5init_tag_out-- 
    ); -- 
  -- module a5reg
  a5reg_out_args <= a5reg_ret_val_x_x ;
  -- call arbiter for module a5reg
  a5reg_arbiter: SplitCallArbiterNoInargs -- 
    generic map( --
      num_reqs => 2,
      return_data_width => 32,
      callee_tag_length => 2,
      caller_tag_length => 1--
    )
    port map(-- 
      call_reqs => a5reg_call_reqs,
      call_acks => a5reg_call_acks,
      return_reqs => a5reg_return_reqs,
      return_acks => a5reg_return_acks,
      call_tag  => a5reg_call_tag,
      return_tag  => a5reg_return_tag,
      call_mtag => a5reg_tag_in,
      return_mtag => a5reg_tag_out,
      return_data =>a5reg_return_data,
      call_mreq => a5reg_start_req,
      call_mack => a5reg_start_ack,
      return_mreq => a5reg_fin_req,
      return_mack => a5reg_fin_ack,
      return_mdata => a5reg_out_args,
      clk => clk, 
      reset => reset --
    ); --
  a5reg_instance:a5reg-- 
    generic map(tag_length => 2)
    port map(-- 
      ret_val_x_x => a5reg_ret_val_x_x,
      start_req => a5reg_start_req,
      start_ack => a5reg_start_ack,
      fin_req => a5reg_fin_req,
      fin_ack => a5reg_fin_ack,
      clk => clk,
      reset => reset,
      memory_space_0_lr_req => memory_space_0_lr_req(2 downto 2),
      memory_space_0_lr_ack => memory_space_0_lr_ack(2 downto 2),
      memory_space_0_lr_addr => memory_space_0_lr_addr(2 downto 2),
      memory_space_0_lr_tag => memory_space_0_lr_tag(5 downto 4),
      memory_space_0_lc_req => memory_space_0_lc_req(2 downto 2),
      memory_space_0_lc_ack => memory_space_0_lc_ack(2 downto 2),
      memory_space_0_lc_data => memory_space_0_lc_data(95 downto 64),
      memory_space_0_lc_tag => memory_space_0_lc_tag(5 downto 4),
      memory_space_1_lr_req => memory_space_1_lr_req(2 downto 2),
      memory_space_1_lr_ack => memory_space_1_lr_ack(2 downto 2),
      memory_space_1_lr_addr => memory_space_1_lr_addr(2 downto 2),
      memory_space_1_lr_tag => memory_space_1_lr_tag(5 downto 4),
      memory_space_1_lc_req => memory_space_1_lc_req(2 downto 2),
      memory_space_1_lc_ack => memory_space_1_lc_ack(2 downto 2),
      memory_space_1_lc_data => memory_space_1_lc_data(95 downto 64),
      memory_space_1_lc_tag => memory_space_1_lc_tag(5 downto 4),
      memory_space_2_lr_req => memory_space_2_lr_req(2 downto 2),
      memory_space_2_lr_ack => memory_space_2_lr_ack(2 downto 2),
      memory_space_2_lr_addr => memory_space_2_lr_addr(2 downto 2),
      memory_space_2_lr_tag => memory_space_2_lr_tag(5 downto 4),
      memory_space_2_lc_req => memory_space_2_lc_req(2 downto 2),
      memory_space_2_lc_ack => memory_space_2_lc_ack(2 downto 2),
      memory_space_2_lc_data => memory_space_2_lc_data(95 downto 64),
      memory_space_2_lc_tag => memory_space_2_lc_tag(5 downto 4),
      memory_space_0_sr_req => memory_space_0_sr_req(2 downto 2),
      memory_space_0_sr_ack => memory_space_0_sr_ack(2 downto 2),
      memory_space_0_sr_addr => memory_space_0_sr_addr(2 downto 2),
      memory_space_0_sr_data => memory_space_0_sr_data(95 downto 64),
      memory_space_0_sr_tag => memory_space_0_sr_tag(5 downto 4),
      memory_space_0_sc_req => memory_space_0_sc_req(2 downto 2),
      memory_space_0_sc_ack => memory_space_0_sc_ack(2 downto 2),
      memory_space_0_sc_tag => memory_space_0_sc_tag(5 downto 4),
      memory_space_1_sr_req => memory_space_1_sr_req(2 downto 2),
      memory_space_1_sr_ack => memory_space_1_sr_ack(2 downto 2),
      memory_space_1_sr_addr => memory_space_1_sr_addr(2 downto 2),
      memory_space_1_sr_data => memory_space_1_sr_data(95 downto 64),
      memory_space_1_sr_tag => memory_space_1_sr_tag(5 downto 4),
      memory_space_1_sc_req => memory_space_1_sc_req(2 downto 2),
      memory_space_1_sc_ack => memory_space_1_sc_ack(2 downto 2),
      memory_space_1_sc_tag => memory_space_1_sc_tag(5 downto 4),
      memory_space_2_sr_req => memory_space_2_sr_req(2 downto 2),
      memory_space_2_sr_ack => memory_space_2_sr_ack(2 downto 2),
      memory_space_2_sr_addr => memory_space_2_sr_addr(2 downto 2),
      memory_space_2_sr_data => memory_space_2_sr_data(95 downto 64),
      memory_space_2_sr_tag => memory_space_2_sr_tag(5 downto 4),
      memory_space_2_sc_req => memory_space_2_sc_req(2 downto 2),
      memory_space_2_sc_ack => memory_space_2_sc_ack(2 downto 2),
      memory_space_2_sc_tag => memory_space_2_sc_tag(5 downto 4),
      tag_in => a5reg_tag_in,
      tag_out => a5reg_tag_out-- 
    ); -- 
  -- module main_inner
  main_inner_instance:main_inner-- 
    generic map(tag_length => 1)
    port map(-- 
      ret_val_x_x => main_inner_ret_val_x_x,
      start_req => main_inner_start_req,
      start_ack => main_inner_start_ack,
      fin_req => main_inner_fin_req,
      fin_ack => main_inner_fin_ack,
      clk => clk,
      reset => reset,
      memory_space_0_lr_req => memory_space_0_lr_req(0 downto 0),
      memory_space_0_lr_ack => memory_space_0_lr_ack(0 downto 0),
      memory_space_0_lr_addr => memory_space_0_lr_addr(0 downto 0),
      memory_space_0_lr_tag => memory_space_0_lr_tag(1 downto 0),
      memory_space_0_lc_req => memory_space_0_lc_req(0 downto 0),
      memory_space_0_lc_ack => memory_space_0_lc_ack(0 downto 0),
      memory_space_0_lc_data => memory_space_0_lc_data(31 downto 0),
      memory_space_0_lc_tag => memory_space_0_lc_tag(1 downto 0),
      memory_space_1_lr_req => memory_space_1_lr_req(0 downto 0),
      memory_space_1_lr_ack => memory_space_1_lr_ack(0 downto 0),
      memory_space_1_lr_addr => memory_space_1_lr_addr(0 downto 0),
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
      memory_space_0_sr_req => memory_space_0_sr_req(0 downto 0),
      memory_space_0_sr_ack => memory_space_0_sr_ack(0 downto 0),
      memory_space_0_sr_addr => memory_space_0_sr_addr(0 downto 0),
      memory_space_0_sr_data => memory_space_0_sr_data(31 downto 0),
      memory_space_0_sr_tag => memory_space_0_sr_tag(1 downto 0),
      memory_space_0_sc_req => memory_space_0_sc_req(0 downto 0),
      memory_space_0_sc_ack => memory_space_0_sc_ack(0 downto 0),
      memory_space_0_sc_tag => memory_space_0_sc_tag(1 downto 0),
      memory_space_1_sr_req => memory_space_1_sr_req(0 downto 0),
      memory_space_1_sr_ack => memory_space_1_sr_ack(0 downto 0),
      memory_space_1_sr_addr => memory_space_1_sr_addr(0 downto 0),
      memory_space_1_sr_data => memory_space_1_sr_data(31 downto 0),
      memory_space_1_sr_tag => memory_space_1_sr_tag(1 downto 0),
      memory_space_1_sc_req => memory_space_1_sc_req(0 downto 0),
      memory_space_1_sc_ack => memory_space_1_sc_ack(0 downto 0),
      memory_space_1_sc_tag => memory_space_1_sc_tag(1 downto 0),
      memory_space_2_sr_req => memory_space_2_sr_req(0 downto 0),
      memory_space_2_sr_ack => memory_space_2_sr_ack(0 downto 0),
      memory_space_2_sr_addr => memory_space_2_sr_addr(0 downto 0),
      memory_space_2_sr_data => memory_space_2_sr_data(31 downto 0),
      memory_space_2_sr_tag => memory_space_2_sr_tag(1 downto 0),
      memory_space_2_sc_req => memory_space_2_sc_req(0 downto 0),
      memory_space_2_sc_ack => memory_space_2_sc_ack(0 downto 0),
      memory_space_2_sc_tag => memory_space_2_sc_tag(1 downto 0),
      memory_space_3_sr_req => memory_space_3_sr_req(1 downto 0),
      memory_space_3_sr_ack => memory_space_3_sr_ack(1 downto 0),
      memory_space_3_sr_addr => memory_space_3_sr_addr(3 downto 0),
      memory_space_3_sr_data => memory_space_3_sr_data(63 downto 0),
      memory_space_3_sr_tag => memory_space_3_sr_tag(1 downto 0),
      memory_space_3_sc_req => memory_space_3_sc_req(1 downto 0),
      memory_space_3_sc_ack => memory_space_3_sc_ack(1 downto 0),
      memory_space_3_sc_tag => memory_space_3_sc_tag(1 downto 0),
      memory_space_4_sr_req => memory_space_4_sr_req(0 downto 0),
      memory_space_4_sr_ack => memory_space_4_sr_ack(0 downto 0),
      memory_space_4_sr_addr => memory_space_4_sr_addr(0 downto 0),
      memory_space_4_sr_data => memory_space_4_sr_data(31 downto 0),
      memory_space_4_sr_tag => memory_space_4_sr_tag(0 downto 0),
      memory_space_4_sc_req => memory_space_4_sc_req(0 downto 0),
      memory_space_4_sc_ack => memory_space_4_sc_ack(0 downto 0),
      memory_space_4_sc_tag => memory_space_4_sc_tag(0 downto 0),
      outpipe_pipe_write_req => outpipe_pipe_write_req(0 downto 0),
      outpipe_pipe_write_ack => outpipe_pipe_write_ack(0 downto 0),
      outpipe_pipe_write_data => outpipe_pipe_write_data(31 downto 0),
      a5reg_call_reqs => a5reg_call_reqs(0 downto 0),
      a5reg_call_acks => a5reg_call_acks(0 downto 0),
      a5reg_call_tag => a5reg_call_tag(0 downto 0),
      a5reg_return_reqs => a5reg_return_reqs(0 downto 0),
      a5reg_return_acks => a5reg_return_acks(0 downto 0),
      a5reg_return_data => a5reg_return_data(31 downto 0),
      a5reg_return_tag => a5reg_return_tag(0 downto 0),
      a5init_call_reqs => a5init_call_reqs(0 downto 0),
      a5init_call_acks => a5init_call_acks(0 downto 0),
      a5init_call_tag => a5init_call_tag(0 downto 0),
      a5init_return_reqs => a5init_return_reqs(0 downto 0),
      a5init_return_acks => a5init_return_acks(0 downto 0),
      a5init_return_tag => a5init_return_tag(0 downto 0),
      tag_in => main_inner_tag_in,
      tag_out => main_inner_tag_out-- 
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
  RegisterBank_memory_space_0: register_bank -- 
    generic map(-- 
      num_loads => 3,
      num_stores => 3,
      addr_width => 1,
      data_width => 32,
      tag_width => 2,
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
      num_stores => 3,
      addr_width => 1,
      data_width => 32,
      tag_width => 2,
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
      num_loads => 3,
      num_stores => 3,
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
  RegisterBank_memory_space_3: register_bank -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 2,
      addr_width => 2,
      data_width => 32,
      tag_width => 1,
      num_registers => 2) -- 
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
