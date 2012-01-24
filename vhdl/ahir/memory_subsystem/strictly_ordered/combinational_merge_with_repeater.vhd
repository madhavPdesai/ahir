library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;

entity combinational_merge_with_repeater is
  generic (
    g_data_width       : natural;
    g_number_of_inputs: natural;
    g_time_stamp_width : natural);
  port(
    clk : in std_logic;
    reset : in std_logic;
    in_data: in std_logic_vector((g_data_width*g_number_of_inputs)-1 downto 0);
    in_tstamp: in std_logic_vector((g_number_of_inputs*g_time_stamp_width)-1 downto 0);
    out_data: out std_logic_vector(g_data_width-1 downto 0);
    out_tstamp: out std_logic_vector(g_time_stamp_width-1 downto 0);
    in_req: in std_logic_vector(g_number_of_inputs-1 downto 0);
    in_ack: out std_logic_vector(g_number_of_inputs-1 downto 0);
    out_req: out std_logic;
    out_ack: in std_logic);
end combinational_merge_with_repeater;

architecture Struct of combinational_merge_with_repeater is

  signal sel_vector : std_logic_vector(g_number_of_inputs-1 downto 0);

  signal rep_data_in : std_logic_vector(g_data_width-1 downto 0);
  signal rep_req_in, rep_ack_out: std_logic;
  
begin  

   cmerge: combinational_merge 
		generic map (g_data_width => g_data_width,
			 g_number_of_inputs => g_number_of_inputs,
			 g_time_stamp_width => g_time_stamp_width)
		port map(in_data => in_data,
			 in_tstamp => in_tstamp,
			 out_data => rep_data_in,
			 out_tstamp => open,
			 in_req => in_req,
			 in_ack => in_ack,
			 out_req => rep_req_in,
			 out_ack => rep_ack_out);

    rptr:  mem_repeater generic map (g_data_width => g_data_width)
		port map(clk => clk, reset => reset,
			 data_in => rep_data_in,
			 req_in => rep_req_in,
			 ack_out => rep_ack_out,
			 data_out => out_data,
			 req_out => out_req,
			 ack_in => out_ack);	
  
end Struct;
