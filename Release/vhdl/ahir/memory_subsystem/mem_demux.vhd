library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;

entity mem_demux is
  generic ( g_data_width: natural := 10;
            g_id_width : natural := 3;
            g_number_of_outputs: natural := 8;
	    g_delay_count: natural := 1);
  port(data_in: in std_logic_vector(g_data_width-1 downto 0);  -- data & id & time-stamp
       sel_in : in std_logic_vector(g_id_width-1 downto 0);
       req_in: in std_logic;
       ack_out : out std_logic;
       data_out: out std_logic_vector((g_number_of_outputs*g_data_width)-1 downto 0 );
       req_out: out std_logic_vector(g_number_of_outputs-1 downto 0);
       ack_in : in std_logic_vector(g_number_of_outputs-1 downto 0);
       clk: in std_logic;
       reset: in std_logic);
end entity;

architecture behave of mem_demux is
  type SigArrayType is array (natural range <>) of std_logic_vector(g_data_width-1 downto 0);

  signal data_out_sig,repeater_out_sig : SigArrayType(g_number_of_outputs-1 downto 0);
  signal req_out_sig, ack_in_sig : std_logic_vector(g_number_of_outputs-1 downto 0);

begin  -- behave


  process(ack_in_sig)
    variable ack_out_var : std_logic;
  begin
    ack_out_var := '0';
    for I in 0 to g_number_of_outputs-1 loop
      ack_out_var := ack_out_var or ack_in_sig(I);
    end loop;  -- I
    ack_out <= ack_out_var;
  end process;
    
  gen: for I in 0 to g_number_of_outputs-1 generate

    data_out_sig(I) <= data_in;
    
    process(data_in, sel_in, req_in)
      variable port_index : natural;
    begin
      port_index := To_Integer(sel_in);
      req_out_sig(I) <= '0';
      if(req_in = '1' and port_index = I) then
        req_out_sig(I) <= req_in;
      end if;
    end process;
      
    Repeater : mem_shift_repeater generic map(g_data_width => g_data_width, g_number_of_stages => g_delay_count)
    port map (
      clk      => clk,
      reset    => reset,
      data_in  => data_out_sig(I),
      req_in   => req_out_sig(I),
      ack_out  => ack_in_sig(I),
      data_out => repeater_out_sig(I),
      req_out  => req_out(I),
      ack_in   => ack_in(I));

    data_out((I+1)*g_data_width -1 downto I*g_data_width) <= repeater_out_sig(I);
  end generate gen;

end behave;
