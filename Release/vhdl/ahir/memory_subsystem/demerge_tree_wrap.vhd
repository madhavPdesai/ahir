library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;

entity demerge_tree_wrap is
  generic (
    g_demux_degree: natural;
    g_number_of_outputs: natural;
    g_data_width: natural;
    g_id_width: natural;
    g_stage_id: natural
    );       

  port (
    demerge_data_out : out std_logic_vector((g_data_width*g_number_of_outputs)-1 downto 0);
    demerge_ready_out  : out std_logic_vector(g_number_of_outputs-1 downto 0);
    demerge_accept_in   : in std_logic_vector(g_number_of_outputs-1 downto 0);
    demerge_data_in: in std_logic_vector(g_data_width-1 downto 0);
    demerge_ack_out : out std_logic;
    demerge_req_in  : in std_logic;
    demerge_sel_in: in std_logic_vector(g_id_width-1 downto 0);
    clock: in std_logic;
    reset: in std_logic);
  
end demerge_tree_wrap;



architecture wrapper of demerge_tree_wrap is
begin
      
      demTree: component demerge_tree
        generic map (
          g_data_width => g_data_width,
          g_id_width   => g_id_width,
          g_number_of_outputs => g_number_of_outputs,
          g_stage_id => g_stage_id,
          g_demux_degree => g_demux_degree)
        port map (
          demerge_data_out => demerge_data_out,
          demerge_ready_out => demerge_ready_out,
          demerge_accept_in => demerge_accept_in,
          demerge_data_in   => demerge_data_in,
          demerge_req_in  => demerge_req_in,
          demerge_ack_out => demerge_ack_out,
          demerge_sel_in  => demerge_sel_in,
          clock => clock,
          reset => reset);
end wrapper;




