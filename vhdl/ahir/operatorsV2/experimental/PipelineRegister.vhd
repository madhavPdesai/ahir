library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

--
-- a full rate register.
-- has a path from read-req to write-ack which
-- can cause long combinational paths.
--
entity PipelineRegister is
  generic (name : string; data_width: integer);
  port (
    read_req       : in  std_logic;
    read_ack       : out std_logic;
    read_data      : out std_logic_vector(data_width-1 downto 0);
    write_req       : in  std_logic;
    write_ack       : out std_logic;
    write_data      : in std_logic_vector((data_width-1) downto 0);
    clk, reset : in  std_logic);
  
end PipelineRegister;

architecture default_arch of PipelineRegister is

   type FsmState is (Empty, Full);
   signal fsm_state : FsmState;
   signal data_reg : std_logic_vector(data_width-1 downto 0);
  
begin  -- default_arch

	process(clk, reset, write_req, read_req, write_data, fsm_state)
		variable next_state : FsmState;
		variable read_ack_v, write_ack_v, latch_v : std_logic;
	begin
		next_state := fsm_state;
		read_ack_v := '0';
		write_ack_v := '0';
		latch_v := '0';
	
		case fsm_state is 
			when Empty =>
				write_ack_v := '1';
				if(write_req = '1') then
					next_state := Full;
					latch_v := '1';
				end if;
			when Full =>
				read_ack_v := '1';
				if(read_req = '1') then
					write_ack_v := '1';
					if(write_req = '0') then
						next_state := Empty;
					else
						latch_v := '1';
					end if;
				end if;
		end case;
					
		write_ack <= write_ack_v;
		read_ack  <= read_ack_v;

		if(clk'event and clk = '1') then
			if(reset = '1') then
				fsm_state <= Empty;
			else
				fsm_state <= next_state;
			end if;

			if(latch_v = '1') then
				data_reg <= write_data;
			end if;
		end if;
	end process;

	read_data <=  data_reg;
end default_arch;
