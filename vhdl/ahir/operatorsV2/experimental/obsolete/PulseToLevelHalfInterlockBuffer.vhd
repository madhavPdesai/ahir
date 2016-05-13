library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

-- 
--  An interlock with a write interface
--  triggered by a pulse protocol and completed
--  by a level protocol.  The read-interface
--  is entirely regulated by a pulse protocol.
--
entity PulseToLevelHalfInterlockBuffer is
  generic (name : string; data_width: integer; buffer_size : integer);
  port( sample_req : in boolean;
        sample_ack : out boolean;
        has_room : out std_logic;
        write_enable : in  std_logic;
        write_data : in std_logic_vector(data_width-1 downto 0);
        update_req : in boolean;
        update_ack : out boolean;
        read_data : out std_logic_vector(data_width-1 downto 0);
        clk : in std_logic;
        reset : in std_logic);
end entity;

architecture Behave of PulseToLevelHalfInterlockBuffer is

  type SampleFsmState is (Idle, WaitForBuf, WaitForWrite);
  signal sample_fsm_state: SampleFsmState;

  signal buf_write, buf_has_room: std_logic;
begin  -- Behave

   buf: UnloadBuffer generic map (name => name & " buffer ",
				data_width => data_width,
			 	buffer_size => buffer_size,
				bypass_flag => true, full_rate => true)
		port map(write_req => buf_write,
                         write_ack => buf_has_room,
			 write_data => write_data,
			 unload_req => update_req,
			 unload_ack => update_ack,
                         read_data => read_data,
			 clk => clk, reset => reset);		


   -- Sample FSM.  sample_req/ack regulates sampling into buffer.
   process(clk,sample_fsm_state,reset,buf_has_room,write_enable,sample_req)
	variable nstate: SampleFsmState;
   begin
	nstate := sample_fsm_state;

	has_room <= '0';
	buf_write <= '0';
        sample_ack <= false;

	case sample_fsm_state is
		when Idle => 
			if(sample_req and (buf_has_room = '1')) then
				has_room <= '1';
				if (write_enable = '1') then
					buf_write <= '1';
					sample_ack <= true;
				else
					nstate := WaitForWrite;
				end if;
			elsif(sample_req and (buf_has_room = '0')) then
				nstate := WaitForBuf;
			end if;
		when WaitForBuf =>
			if(buf_has_room = '1') then
				has_room <= '1';
				if (write_enable = '1') then
					buf_write <= '1';
					sample_ack <= true;
					nstate := Idle;
				else
					nstate := WaitForWrite;
				end if;
			end if;
		when WaitForWrite =>
			has_room <= '1';
			if(write_enable = '1') then
				buf_write <= '1';
				sample_ack <= true;
				nstate := Idle;
			end if;
	end case;


	if(clk'event and clk = '1') then
		if(reset = '1') then
			sample_fsm_state <= Idle;
		else	
			sample_fsm_state <= nstate;
		end if;
	end if;
   end process;

end Behave;
