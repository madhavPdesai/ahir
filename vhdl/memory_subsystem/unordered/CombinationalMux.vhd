library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.types.all;
use ahir.utilities.all;
use ahir.subprograms.all;

entity CombinationalMux is
  generic (
    g_data_width       : integer := 32;
    g_number_of_inputs: integer := 2);
  port(
    in_data: in std_logic_vector((g_data_width*g_number_of_inputs)-1 downto 0);
    out_data: out std_logic_vector(g_data_width-1 downto 0);
    in_req: in std_logic_vector(g_number_of_inputs-1 downto 0);
    in_ack: out std_logic_vector(g_number_of_inputs-1 downto 0);
    out_req: out std_logic;
    out_ack: in std_logic);
end CombinationalMux;

architecture combinational_merge of CombinationalMux is

  signal sel_vector : std_logic_vector(g_number_of_inputs-1 downto 0);
  
begin  -- combinational_merge

  sel_vector <= PriorityEncode(in_req);
  out_req <= OrReduce(in_req);
  in_ack <= sel_vector when out_ack = '1' else (others => '0');



  process(sel_vector,in_data)
  begin
    out_data <= (others => '0');
    for I in 0 to g_number_of_inputs-1 loop
	if(sel_vector(I) = '1') then
	 	out_data <= in_data((g_data_width*(I+1))-1 downto (g_data_width*I));
		exit;
	end if;
    end loop;
  end process;
	   
  
  AckGen: for I in 0 to g_number_of_inputs-1 generate
    in_ack(I) <= '1' when (sel_vector(I) = '1'  and out_ack = '1' and in_req(I) = '1') else '0';
  end generate AckGen;
  
end combinational_merge;
