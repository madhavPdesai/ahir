library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

--
-- base Pipe.
--  in all cases, we will go for an implementation which
--  gives a throughput of one word/cycle.
--

entity SignalBase is
  generic (name : string;
           num_writes: integer;
           data_width: integer);
  port (
    read_data      : out std_logic_vector(data_width-1 downto 0);
    write_req       : in  std_logic_vector(num_writes-1 downto 0);
    write_ack       : out std_logic_vector(num_writes-1 downto 0);
    write_data      : in std_logic_vector((num_writes*data_width)-1 downto 0);
    clk, reset : in  std_logic);
  
end SignalBase;

architecture default_arch of SignalBase is

  signal pipe_data: std_logic_vector(data_width-1 downto 0);
  signal pipe_req, pipe_ack: std_logic;
  
begin  -- default_arch


  manyWriters: if (num_writes > 1) generate
    wmux : OutputPortLevel generic map (
      num_reqs       => num_writes,
      data_width     => data_width,
      no_arbitration => false)
      port map (
        req   => write_req,
        ack   => write_ack,
        data  => write_data,
        oreq  => pipe_req,                -- no cross-over, drives req
        oack  => pipe_ack,                -- no cross-over, receives ack
        odata => pipe_data,
        clk   => clk,
        reset => reset);
  end generate manyWriters;

  singleWriter: if (num_writes = 1) generate
    pipe_req <= write_req(0);
    write_ack(0) <= pipe_ack;
    pipe_data <= write_data;
  end generate singleWriter;
 
  -- in signal mode, the pipe is just a flag
  -- write always succeeds.
  pipe_ack <= '1';
  process(clk,reset) 
  begin
	if(clk'event and clk = '1') then
		if(reset = '1') then
			read_data <= (others => '0');	
		else
			if(pipe_req = '1') then
				read_data <= pipe_data;
			end if;
		end if;
	end if;
  end process;

end default_arch;
