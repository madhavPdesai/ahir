library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.BaseComponents.all;
use ahir.Utilities.all;
use ahir.Subprograms.all;
use ahir.mem_function_pack.all;
use ahir.merge_functions.all;
use ahir.mem_component_pack.all;
use ahir.Utilities.all;

entity PipelinedDemux is
  generic ( g_data_width: natural := 10;
            g_destination_id_width : natural := 3;
            g_number_of_outputs: natural := 8);
  port(data_in: in std_logic_vector(g_data_width-1 downto 0);  -- data & destination-id 
       sel_in : in std_logic_vector(g_destination_id_width-1 downto 0);
       req_in: in std_logic;
       ack_out : out std_logic;
       data_out: out std_logic_vector((g_number_of_outputs*g_data_width)-1 downto 0 );
       req_out: out std_logic_vector(g_number_of_outputs-1 downto 0);
       ack_in : in std_logic_vector(g_number_of_outputs-1 downto 0);
       clk: in std_logic;
       reset: in std_logic);
end entity;

architecture behave of PipelinedDemux is
  type SigArrayType is array (natural range <>) of std_logic_vector(g_data_width-1 downto 0);

  signal data_out_sig,repeater_out_sig : SigArrayType(g_number_of_outputs-1 downto 0);
  signal req_out_sig, ack_in_sig : std_logic_vector(g_number_of_outputs-1 downto 0);
  signal conditioned_ack_in_sig: std_logic_vector(g_number_of_outputs-1 downto 0);

begin  -- behave

  
  conditioned_ack_in_sig <= ack_in_sig and req_out_sig;
  ack_out <= OrReduce(conditioned_ack_in_sig);
    
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
      
    Repeater : QueueBase generic map(queue_depth => 2, data_width => g_data_width)
    port map (
      clk      => clk,
      reset    => reset,
      data_in  => data_out_sig(I),
      push_req  => req_out_sig(I),
      push_ack  => ack_in_sig(I),
      data_out => repeater_out_sig(I),
      pop_ack  => req_out(I),
      pop_Req   => ack_in(I));

    data_out((I+1)*g_data_width -1 downto I*g_data_width) <= repeater_out_sig(I);
  end generate gen;

end behave;
