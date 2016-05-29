library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

--
-- returns 0 if there is no data available for reading.
--  (data must be coded so that all-0's is invalid).
--

entity NonblockingReadPipeBase is
  generic (name : string;
	   num_reads: integer;
           num_writes: integer;
           data_width: integer;
           lifo_mode: boolean := false;
           depth: integer := 1;
	   signal_mode: boolean := false;
	   shift_register_mode: boolean := false;
	   full_rate: boolean);
  port (
    read_req       : in  std_logic_vector(num_reads-1 downto 0);
    read_ack       : out std_logic_vector(num_reads-1 downto 0);
    read_data      : out std_logic_vector((num_reads*data_width)-1 downto 0);
    write_req       : in  std_logic_vector(num_writes-1 downto 0);
    write_ack       : out std_logic_vector(num_writes-1 downto 0);
    write_data      : in std_logic_vector((num_writes*data_width)-1 downto 0);
    clk, reset : in  std_logic);
  
end NonblockingReadPipeBase;

architecture default_arch of NonblockingReadPipeBase is

   signal write_req_nb       : std_logic_vector(num_reads-1 downto 0);
   signal write_ack_nb       : std_logic_vector(num_reads-1 downto 0);
   signal write_data_nb      : std_logic_vector((num_reads*data_width)-1 downto 0);
  
begin  -- default_arch

 
	pb: PipeBase generic map (name => name & "-pb" ,
				    num_reads => num_reads,
					num_writes => num_writes,
				         data_width => data_width,
						lifo_mode => lifo_mode, 
							depth => depth,
								signal_mode => signal_mode, 
									full_rate => full_rate)
		port map(read_req => write_ack_nb,
			   read_ack => write_req_nb,
				read_data => write_data_nb,
					write_req => write_req,
					  write_ack => write_ack,
						write_data => write_data,
							clk => clk, reset => reset);


	genNB: for I in 0 to num_reads-1 generate

		nb: PipeUnblock 
			generic map (name => name & "-nb-" & Convert_To_String(I),
					data_width => data_width)
			port map (write_req => write_req_nb(I),
					write_ack => write_ack_nb(I),
						write_data => write_data_nb (((I+1)*data_width)-1 downto (I*data_width)),
							read_req => read_req(I),
								read_ack => read_ack(I),
									read_data => read_data (((I+1)*data_width)-1 downto (I*data_width)),
										clk => clk, reset => reset);
	end generate genNB;

end default_arch;
