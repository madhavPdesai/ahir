library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;

entity demerge_tree is
  generic (
    g_demux_degree: natural := 10;
    g_number_of_outputs: natural := 5;
    g_data_width: natural := 8;
    g_id_width: natural := 3;
    g_stage_id: natural := 0
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
end demerge_tree;

-- a much simpler architecture, which is likely to be equally
-- effective.
architecture Simple of demerge_tree is
  constant inserted_delay  : integer := Maximum(1,Ceil_Log2(g_number_of_outputs/g_demux_degree));
begin  -- Simple

  demux : mem_demux generic map (
    g_data_width        => g_data_width,
    g_id_width          => g_id_width,
    g_number_of_outputs => g_number_of_outputs,
    g_delay_count => inserted_delay)
    port map (
      data_in  => demerge_data_in,
      sel_in   => demerge_sel_in,
      req_in   => demerge_req_in,
      ack_out  => demerge_ack_out,
      data_out => demerge_data_out,
      req_out  => demerge_ready_out,
      ack_in   => demerge_accept_in,
      clk      => clock,
      reset    => reset);
end Simple;




