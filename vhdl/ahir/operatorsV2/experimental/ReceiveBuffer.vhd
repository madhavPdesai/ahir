-- TODO: add bypass path to the receive buffer.
--       this will reduce buffering requirements
--       by a factor of two (for full pipelining).
--
library ieee;
use ieee.std_logic_1164.all;

library ahir;
use ahir.Types.all;
use ahir.Subprograms.all;
use ahir.Utilities.all;
use ahir.BaseComponents.all;

entity ReceiveBuffer  is
  generic (name: string; buffer_size: integer := 2; data_width : integer := 32; kill_counter_range: integer := 65535);
  port ( write_req: in boolean;
         write_ack: out boolean;
         write_data: in std_logic_vector(data_width-1 downto 0);
         read_req: in std_logic;
         read_ack: out std_logic;
	 kill      : in std_logic;
         read_data: out std_logic_vector(data_width-1 downto 0);
         clk : in std_logic;
         reset: in std_logic);
end ReceiveBuffer;

architecture default_arch of ReceiveBuffer is

  signal push_req, push_ack, pop_req, pop_ack: std_logic_vector(0 downto 0);
  signal pipe_data_in:  std_logic_vector(data_width-1 downto 0);


  signal kill_counter : integer range 0 to kill_counter_range;
  signal kill_counter_incr, kill_counter_decr: boolean;

  type RxBufFsmState is (idle, busy);
  signal fsm_state : RxBufFsmState;


  signal kill_active: boolean;

begin  -- default_arch

  -- the output pipe.
  bufPipe : PipeBase generic map (
    name =>  name & " fifo ",
    num_reads  => 1,
    num_writes => 1,
    data_width => data_width,
    lifo_mode  => false,
    depth      => buffer_size)
    port map (
      read_req   => pop_req,
      read_ack   => pop_ack,
      read_data  => read_data,
      write_req  => push_req,
      write_ack  => push_ack,
      write_data => write_data,
      clk        => clk,
      reset      => reset);
  read_ack <= pop_ack(0);
  pop_req(0) <= read_req;


  -- FSM
  process(clk,reset, write_req, push_ack,kill_active,kill)
	variable nstate : RxBufFsmState;
	variable pushreqv: std_logic;
	variable decr: boolean;
	variable wackv : boolean;
  begin
	decr := false; 
	wackv := false;
	pushreqv := '0'; 

	nstate := fsm_state;
	case fsm_state is
		when idle => 
			if(write_req and kill_active) then
				decr := true;
				wackv := true;	
			elsif(write_req and (push_ack(0) = '1') and (not kill_active)) then
				wackv := true;
				pushreqv := '1';
			elsif (write_req and (push_ack(0) = '0') and (not kill_active)) then
				nstate := busy;	
			end if;
		when busy => 
			if(kill = '1') then
				decr := true;
				wackv := true;
				nstate := idle;
			elsif (push_ack(0) = '1') then
				nstate := idle;
				pushreqv := '1';
				wackv := true;
			end if;
	end case;

	push_req(0) <= pushreqv;
	write_ack <= wackv;
	kill_counter_decr <= decr;

	if(clk'event and clk = '1') then
		if(reset = '1') then
			fsm_state <= idle;
		else
			fsm_state <= nstate;
		end if;
	end if;
		
  end process;


  -- kill counter.
  kill_active <= (kill = '1') or (kill_counter > 0);
  kill_counter_incr <= (kill = '1');
  process(clk)
  begin
	if(clk'event and clk = '1') then
		if(reset = '1') then
			kill_counter <= 0;
		else
			if(kill_counter_decr and (not kill_counter_incr)) then
				kill_counter <= kill_counter - 1;
			elsif ((not kill_counter_decr) and kill_counter_incr) then
				kill_counter <= kill_counter + 1;
			end if;
		end if;
	end if;
  end process;

end default_arch;
