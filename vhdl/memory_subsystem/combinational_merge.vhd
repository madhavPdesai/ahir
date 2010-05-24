library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;

entity combinational_merge is
  generic (
    g_data_width       : natural;
    g_number_of_inputs: natural;
    g_time_stamp_width : natural);
  port(
    in_data: in std_logic_vector((g_data_width*g_number_of_inputs)-1 downto 0);
    in_tstamp: in std_logic_vector((g_number_of_inputs*g_time_stamp_width)-1 downto 0);
    out_data: out std_logic_vector(g_data_width-1 downto 0);
    out_tstamp: out std_logic_vector(g_time_stamp_width-1 downto 0);
    in_req: in std_logic_vector(g_number_of_inputs-1 downto 0);
    in_ack: out std_logic_vector(g_number_of_inputs-1 downto 0);
    out_req: out std_logic;
    out_ack: in std_logic);
end combinational_merge;

architecture combinational_merge of combinational_merge is

  signal sel_vector : std_logic_vector(g_number_of_inputs-1 downto 0);
  
begin  -- combinational_merge

  process(in_tstamp,in_data,in_req)
    variable best_tstamp_var : std_logic_vector(1 to g_time_stamp_width);
    variable best_data : std_logic_vector(1 to g_data_width);
    variable sel_var : std_logic_vector(g_number_of_inputs-1 downto 0);
    variable vflag : std_logic;
  begin
    Select_Best_Index(in_tstamp,in_data, in_req,best_tstamp_var,best_data,sel_var,vflag);
    if(vflag = '1') then
      out_tstamp <= best_tstamp_var;
      out_data <= best_data;
      sel_vector <= sel_var;
      out_req <= '1';
    else
      out_tstamp <= (others => '0');
      out_data <= (others => '0');
      sel_vector <= (others => '0');
      out_req <= '0';
    end if;
  end process;
  
  AckGen: for I in 0 to g_number_of_inputs-1 generate
    in_ack(I) <= '1' when (sel_vector(I) = '1'  and out_ack = '1' and in_req(I) = '1') else '0';
  end generate AckGen;
  
end combinational_merge;
